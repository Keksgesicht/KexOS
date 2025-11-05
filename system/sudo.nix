{ pkgs, ... }:

let
  options = [ "NOPASSWD" ];
  sysd-bin = "${pkgs.systemd}/bin";
in
{
  security.sudo.enable = false;
  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
    extraRules = [ {
      groups = [ "wheel" ];
      commands = [
        { inherit options; command = "${sysd-bin}/poweroff"; }
        { inherit options; command = "${sysd-bin}/reboot"; }
        { inherit options; command = "${sysd-bin}/systemctl poweroff"; }
        { inherit options; command = "${sysd-bin}/systemctl reboot"; }
        { inherit options; command = "${sysd-bin}/systemctl suspend"; }
      ];
    } ];
  };

  environment.shellAliases = {
    poweroff  = "${sysd-bin}/poweroff";
    reboot    = "${sysd-bin}/reboot";
    systemctl = "${sysd-bin}/systemctl";
  };
}
