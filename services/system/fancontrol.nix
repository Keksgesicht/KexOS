{ config, pkgs, lib, hdd-mnt, ... }:

let
  inherit (config.KexOS.service."dummy".service) serviceConfig;
  fc-bin = "${pkgs.lm_sensors}/bin/fancontrol";
  fc-cfg = (pkgs.callPackage ../../packages/config-fancontrol.nix {});
in
{
  hardware.fancontrol = {
    enable = true;
    config = "";
  };

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/hardware/fancontrol.nix
  systemd.services.fancontrol = {
    overrideStrategy = "asDropinIfExists";
    serviceConfig = serviceConfig // {
      PrivateDevices = "no";
      ExecStartPre = "${fc-cfg}/bin/fancontrol-hwmon-fix.sh";
      ExecStart = lib.mkForce "${fc-bin} /tmp/fancontrol-config";
      InaccessiblePaths = lib.mkForce (builtins.filter (e:
        !(lib.strings.hasPrefix hdd-mnt e)
      ) serviceConfig.InaccessiblePaths.content);
    };
  };

  # load modules for AMD platform
  boot.kernelModules = [
    "nct6775"
  ];
}
