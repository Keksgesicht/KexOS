{ config, pkgs, username, ... }:

let
  uid = builtins.toString config.users.users."${username}".uid;
  sysd = "${pkgs.systemd}/bin/systemctl";
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
    ${sysd} start my-audio-resume.service
  '' ];

  systemd.services = {
    "my-audio-resume" = {
      serviceConfig.User = username;
      environment.XDG_RUNTIME_DIR = "/run/user/${uid}";
      script = ''
        ${sysd} --user restart my-audio.service
      '';
    };
  };
}
