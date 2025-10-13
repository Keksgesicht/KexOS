{ pkgs, lib, ... }:

let
  inherit (lib.lists) forEach;

  hot-list = [ 1 2 ];
  hot-name = (num: "hot_backup_" + (builtins.toString num));
  hot-pkg = pkgs.callPackage ../../packages/backup-hot.nix {};

  req-crypt = (n: "x-systemd.requires=systemd-cryptsetup@${n}.service");
  ctab-tpm2 = (n: "${n} /dev/disk/by-label/${n} - nofail,tpm2-device=auto");

  timer-hot = {
    overrideStrategy = "asDropin";
    wantedBy = [ "timers.target" ];
  };
in
{
  environment.etc."crypttab".text = lib.strings.concatLines (
    forEach hot-list (e: ctab-tpm2 (hot-name e))
  );

  fileSystems."/mnt/hot_backup" = {
    device = "/dev/disk/by-label/hot_backup";
    options = [
      "nofail"
      "compress-force=zstd:3"
      "x-systemd.automount" # makes delayed mounting possible
      "x-systemd.device-timeout=123s" # prevent job removal
    ] ++ forEach hot-list (e: (req-crypt (hot-name e)));
  };

  KexOS.service."backup-hot@" = {
    service  = {
      stopIfChanged = false;
      restartIfChanged = false;
      after = [ "podman-pihole.service" ];
      description = "Hot Backup Job for %i";
      requires = [ "mnt-hot_backup.mount" ];
      path = with pkgs; [ rsync util-linux ];
      serviceConfig = {
        Type = "exec";
        ExecStart = "${hot-pkg}/bin/backup-hot.sh %i";
        ReadWritePaths = "/mnt/hot_backup/data/%i";
        InaccessiblePaths = lib.mkForce [];
      };
    };
    timer.timerConfig.OnCalendar = "*-*-* 06:23:00";
  };
  systemd.timers = {
    "backup-hot@cookieflyer" = timer-hot;
    "backup-hot@cookiemailer" = timer-hot;
    "backup-hot@cookiepi" = timer-hot;
  };
}
