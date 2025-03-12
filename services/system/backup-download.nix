{ pkgs, lib, hdd-mnt, ...}:

let
  bd-pkg = (pkgs.callPackage ../../packages/backup-download.nix {});

  bd-units = (sn: th: {
    tmpfiles.rules = [ "d  ${hdd-mnt}/machines/${sn}" ];
    services."backup-download@${sn}" = {
      path = with pkgs; [ gnutar gzip openssh rsync ];
      description = "Generates Backups from different Remote Systems";
      serviceConfig = {
        Type      = "oneshot";
        ExecStart = "${bd-pkg}/bin/backup-download.sh ${sn} ${th}";

        ProtectHome    = "read-only";
        ProtectProc    = "invisible";
        PrivateTmp     = "yes";
        ProtectClock   = "yes";
        PrivateDevices = "yes";

        ReadOnlyPaths = "/";
        TemporaryFileSystem = "/etc:ro";
        BindReadOnlyPaths = "/etc/ssh/ssh_config";
        ReadWritePaths = "${hdd-mnt}/machines/${sn}";
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
    ({ tmpfiles.rules = [
      "q  ${hdd-mnt}/machines"
    ]; })
    (bd-units "cookieflyer" "cookieflyer.keksgesicht.de")
    (bd-units "cookiemailer" "mail.keksgesicht.de")
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


