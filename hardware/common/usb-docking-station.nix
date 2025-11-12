{ pkgs, username, ... }:

let
  sysd = "${pkgs.systemd}/bin/systemctl --no-block";
  sysd-user = "${sysd} --machine ${username}@.host --user restart";
in
{
  imports = [
    ../../nix/KexOS/resume-commands.nix
    ../common/udev-usb.nix
  ];

  services.udev.usbRule = {
    # keyboard wakeup from suspend
    "99-usb-docking-keyboard-wakeup" = {
      vendor = "1017";
      product = "a002";
      cmd = "ATTR{power/wakeup}=\"enabled\"";
    };
  };

  powerManagement.asyncResumeCommands = [ ''
    sleep 7s
    ${sysd-user} my-audio.service
  '' ];
}
