{ pkgs, lib, myDomain, hdd-mnt, hdd-name, ... }:

let
  bd-pkg = (pkgs.callPackage ../../packages/backup-download.nix {});

  bd-units = (sn: th: {
    tmpfiles.rules = [ "d  ${hdd-mnt}/machines/${sn}" ];
    services."backup-download@${sn}" = {
      path = with pkgs; [ gnutar gzip openssh rsync ];
      requires = [ "mnt-${hdd-name}.mount" ];
      description = "Generates Backups from different Remote Systems";
      serviceConfig = {
        Type      = "oneshot";
        ExecStart = "${bd-pkg}/bin/backup-download.sh ${sn} ${th}";

        ProtectProc    = "invisible";
        PrivateTmp     = "yes";
        ProtectClock   = "yes";
        PrivateDevices = "yes";

        ReadOnlyPaths = "/";
        ReadWritePaths = "${hdd-mnt}/machines/${sn}";
        BindReadOnlyPaths = "/etc/ssh/ssh_config";
        TemporaryFileSystem = [
          "/etc:ro"
          "/root/.cache"
        ];
      };
    };
    timers."backup-download@${sn}" = {
      enable = true;
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 08:15:00";
        RandomizedDelaySec = "42min";
        AccuracySec = "1min";
        Persistent = "true";
      };
    };
  });
in
{
  systemd = lib.mkMerge [
    ({ tmpfiles.rules = [ "q  ${hdd-mnt}/machines" ]; })
    (bd-units "cookieflyer"   "cookieflyer.${myDomain}")
    (bd-units "cookiemailer" "cookiemailer.${myDomain}")
    (bd-units "pihole" "rpi.pihole.internal")
  ];

  /*
   * manual preparation steps:
   *   sudo -i
   *
   *   mkdir -p ~/.secrets/ssh
   *   ssh-keygen
   */
}


