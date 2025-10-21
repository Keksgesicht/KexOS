{ config, lib, cookie-dir, ssd-mnt, ssd-name, hdd-mnt, hdd-name, ... }:

let
  inherit (lib) attrsets mkDefault mkForce mkMerge mkOption strings types;

  defOpt = mkOption { default = { enable = true; }; };
  srvOpts = { name, config, ... }: {
    options = {
      service = defOpt;
      timer   = defOpt;
    };
  };

  wantedBy = [ "timers.target" ];
  serviceConfig = {
    PrivateDevices = mkDefault "yes";
    PrivateTmp     = mkDefault "yes";
    ProtectClock   = mkDefault "yes";
    ProtectHome    = mkDefault "yes";
    ProtectProc    = mkDefault "invisible"; # requires DynamicUser=yes
    ReadOnlyPaths  = mkDefault "/";
    InaccessiblePaths = mkDefault [
      "/etc/nixos"
      "/etc/ssh"
      "/var/log"
      cookie-dir
      "${ssd-mnt}/backup_${ssd-name}"
      "${ssd-mnt}/etc"
      "${ssd-mnt}/var"
      "${ssd-mnt}/root"
      "${hdd-mnt}/backup_${hdd-name}"
      "-${hdd-mnt}/machines"
      "-/mnt/hot_backup"
    ];
  };
  timerConfig = {
    wantedBy = mkDefault wantedBy;
    after = mkDefault [ "boot-delay.service" ];
    timerConfig = {
      RandomizedDelaySec = mkDefault "42min";
      Persistent = mkDefault true;
    };
  };

  srv2sysd = (opt: attrsets.mapAttrs (name: value: ({
    service = mkMerge [ value.service ({ inherit serviceConfig; }) ];
    timer   = mkMerge [ value.timer   (timerConfig) ];
  })."${opt}") (
    attrsets.filterAttrs (n: v: (n != "dummy" && v."${opt}" != {}))
  config.KexOS.service));

  fixTemplateTimers = (attrsets.concatMapAttrs (n: v: {
      "${n}timers" = { wantedBy = []; };
    }) (
      attrsets.filterAttrs (n: v: strings.hasSuffix "@" n) config.KexOS.service
    )
  );
in
{
  options.KexOS.service = mkOption {
    default = {};
    type = with types; attrsOf (submodule srvOpts);
  };

  config.KexOS.service."dummy" = {
    service = { inherit serviceConfig; };
    timer = timerConfig;
  };
  config.KexOS.service."boot-delay" = {
    service = {
      stopIfChanged = false;
      restartIfChanged = false;
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        InaccessiblePaths = mkForce [];
      };
      script = ''
        sleep 13m
        exit 0
      '';
      inherit wantedBy;
    };
    timer = mkForce {};
  };

  config.systemd = {
    services = srv2sysd "service";
    timers   = srv2sysd "timer" // fixTemplateTimers;
  };
}
