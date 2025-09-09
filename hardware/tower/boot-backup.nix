{ pkgs, ... }:

let
  fat-opts = [ "umask=0077" "shortname=winnt" ];
  bootPathBackup = "/mnt/backup/boot";
in
{
  fileSystems."${bootPathBackup}" = { # other NVMe (see /boot)
    device = "/dev/disk/by-uuid/F6A6-57AC";
    fsType = "vfat";
    options = fat-opts ++ [ "nofail" ];
  };

  systemd.services = {
    "backup-boot" = {
      wantedBy = [ "user@1000.service" ];
      after = [ "user@1000.service" ];
      unitConfig.RequiresMountsFor = bootPathBackup;
      serviceConfig.RemainAfterExit = true;
      script = ''
        ${pkgs.coreutils}/bin/sleep 666s
        ${pkgs.rsync}/bin/rsync -rltv --delete /boot/ ${bootPathBackup}/
        ${pkgs.util-linux}/bin/umount ${bootPathBackup}
      '';
    };
  };
}
