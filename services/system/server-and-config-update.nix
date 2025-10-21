{ config, pkgs, lib, ssd-name, ...}:

let
  pkg-scu = (pkgs.callPackage ../../packages/server-and-config-update.nix {});
  inherit (config.KexOS.service."dummy".service) serviceConfig;
in
{
  KexOS.service."server-and-config-update@" = {
    service = {
      description = "Container and Webservice Updater (config)";
      after = [ "mnt-${ssd-name}.mount" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkg-scu}/bin/%i.sh";
        TemporaryFileSystem = "/etc:ro";
        InaccessiblePaths = lib.mkForce (builtins.filter (e:
          !(lib.strings.hasPrefix "/etc" e)
        ) serviceConfig.InaccessiblePaths.content);
      };
    };
    timer = {
      description = "Container and Webservice Update Timer";
      timerConfig.OnCalendar = "*-*-20 20:30:00";
    };
  };
}


