{ pkgs, ssd-name, ...}:

let
  pkg-scu = (pkgs.callPackage ../../packages/server-and-config-update.nix {});
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
      };
    };
    timer = {
      description = "Container and Webservice Update Timer";
      timerConfig.OnCalendar = "*-*-20 20:30:00";
    };
  };
}


