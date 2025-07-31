{ pkgs, ... }:

let
  ctab-tpm2 = (name: ''
    ${name}  /dev/disk/by-label/${name}  -  nofail,tpm2-device=auto
  '');

  pkg-hot = pkgs.callPackage ../../packages/backup-hot.nix {};

  timer-hot = {
    overrideStrategy = "asDropin";
    wantedBy = [ "timers.target" ];
  };
in
{
  environment.etc."crypttab".text = ""
    + (ctab-tpm2 "hot-backup-1")
    + (ctab-tpm2 "hot-backup-2")
    ;

  fileSystems."/mnt/hot_backup" = {
    device = "/dev/disk/by-label/hot-backup";
    options = [
      "nofail"
      "compress-force=zstd:3"
      "x-systemd.automount" # makes delayed mounting possible
      "x-systemd.device-timeout=123s" # prevent job removal
      #"x-systemd.requires=systemd-cryptsetup@hot-backup-1.service"
      #"x-systemd.requires=systemd-cryptsetup@hot-backup-2.service"
    ];
  };

  systemd.services."backup-hot@" = {
    description = "Hot Backup Job for %i";
    requires = [ "mnt-hot_backup.mount" ];
    path = with pkgs; [ rsync util-linux ];
    serviceConfig = {
      Type = "exec";
      ExecStart = "${pkg-hot}/bin/backup-hot.sh %i";

      PrivateTmp   = "yes";
      ProtectHome  = "yes";
      ProtectClock = "yes";
      ProtectProc  = "invisible";

      ReadOnlyPaths  = "/";
      ReadWritePaths = "/mnt/hot_backup/data/%i";
    };
  };
  systemd.timers = {
    "backup-hot@" = {
      timerConfig = {
        OnCalendar = "*-*-* 06:23:00";
        RandomizedDelaySec = "42 min";
        Persistent = true;
      };
      wantedBy = [ "timers.target" ];
    };
    "backup-hot@cookieflyer" = timer-hot;
    "backup-hot@cookiemailer" = timer-hot;
  };
}
