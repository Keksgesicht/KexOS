{ pkgs, username, ... }:

let
  tuxedo-sys-path = "/sys/devices/platform/tuxedo_keyboard/leds/rgb:kbd_backlight";
  tuxedo-backlight-script = pkgs.writeShellScriptBin "reset-tuxedo-backlight" ''
    echo "226 0 116" > ${tuxedo-sys-path}/multi_intensity
    echo "51" > ${tuxedo-sys-path}/brightness
  '';
  tuxedo-backlight-bin = "${tuxedo-backlight-script}/bin/reset-tuxedo-backlight";
in
{
  # https://nixos.wiki/wiki/TUXEDO_Devices
  # https://github.com/AaronErhardt/tuxedo-rs
  hardware.tuxedo-rs = {
    #enable = true;
    #tailor-gui.enable = true;
  };
  hardware.tuxedo-drivers.enable = true;

  # reset backlight color and brightness
  security.sudo-rs.extraRules = [ {
    users = [ username ];
    commands = [ {
      options = [ "NOPASSWD" ];
      command = tuxedo-backlight-bin;
    } ];
  } ];
  users.users."${username}".packages = [ tuxedo-backlight-script ];
  environment.shellAliases = {
    reset-tuxedo-backlight = "sudo ${tuxedo-backlight-bin}";
  };
}
