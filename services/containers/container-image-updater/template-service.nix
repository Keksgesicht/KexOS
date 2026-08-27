{ config, lib, cookie-pkg, ... }:

let
  inherit (config.KexOS.variables) cookie-dir;
  update-days = (builtins.head (builtins.split " " config.system.autoUpgrade.dates));
  image-updater = ../../../files/packages/containers/image-updater;
in
{
  environment.etc = {
    "flake-output/unCookie" = {
      source = cookie-pkg;
    };
  };

  KexOS.service."container-image-updater@" = {
    service = {
      description = "Bump up container image version hashes [%i]";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${image-updater}/bin/get-container-image-hash.sh";
        ReadWritePaths = "${cookie-dir}/containers";
        InaccessiblePaths = lib.mkForce [];
      };
    };
    timer = {
      description = "Automatic container image version updater [%i]";
      timerConfig.OnCalendar = "${update-days} 01:39:24";
    };
  };
}
