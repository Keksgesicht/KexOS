{ config, pkgs, username, ... }:

let
  uid = builtins.toString config.users.users."${username}".uid;
  sysd = "${pkgs.systemd}/bin/systemctl --no-block";
  screen01 = "4e46882a-e325-4556-b6b7-5236f684265e";
  screen02 = "6c22c19e-08b0-410b-8d96-750662f82757";
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
    ${sysd} restart kscreen-resume-wrapper.service
  '' ];

  systemd.services = {
    "kscreen-resume-wrapper" = {
      serviceConfig.User = username;
      environment.XDG_RUNTIME_DIR = "/run/user/${uid}";
      script = ''
        ${sysd} --user restart kscreen-resume.service
      '';
    };
  };

  systemd.user.services = {
    "kscreen-resume" = {
      path = with pkgs; [ coreutils kdePackages.libkscreen ];
      script = ''
        kscreen-doctor output.${screen02}.mode.3840x2160@30
        kscreen-doctor output.${screen01}.mode.5120x1440@60
        sleep 2s
        kscreen-doctor output.${screen01}.mode.5120x1440@120
        kscreen-doctor output.${screen02}.mode.3840x2160@60
      '';
    };
  };
}
