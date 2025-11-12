{ pkgs, username, ... }:

let
  sysd = "${pkgs.systemd}/bin/systemctl --no-block";
  sysd-user = "${sysd} --machine ${username}@.host --user restart";
in
{
  imports = [
    ../common/usb-docking-station.nix
  ];

  services.udev.usbRule = {
    # disable USB ethernet adapter
    "99-usb-docking-disable-ethernet" = {
      vendor = "0b95";
      product = "1790";
      cmd = "ATTR{authorized}=\"0\"";
    };
  };

  powerManagement.asyncResumeCommands = [ ''
    ${sysd-user} kscreen-resume.service
  '' ];

  systemd.user.services = {
    "kscreen-resume" = {
      path = with pkgs; [ coreutils kdePackages.libkscreen ];
      script = ''
        kscreen-doctor output.HDMI-A-1.mode.3840x2160@30
        kscreen-doctor output.DP-1.mode.5120x1440@60
        sleep 1s
        kscreen-doctor output.DP-1.mode.5120x1440@120
        kscreen-doctor output.HDMI-A-1.mode.3840x2160@60
      '';
    };
  };
}
