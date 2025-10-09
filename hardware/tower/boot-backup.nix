{ config, pkgs, lib, ... }:

let
  timerConfig = config.KexOS.service."dummy".timer;
  fat-opts = [ "umask=0077" "shortname=winnt" ];
  bootPathBackup = "/mnt/backup/boot";
in
{
  fileSystems."${bootPathBackup}" = { # other NVMe (see /boot)
    device = "/dev/disk/by-uuid/F6A6-57AC";
    fsType = "vfat";
    options = fat-opts ++ [ "nofail" ];
  };

  KexOS.service."backup-boot" = {
    service = {
      inherit (timerConfig) after;
      wantedBy = [ "user@1000.service" ];
      path = with pkgs; [ coreutils efibootmgr gawk rsync util-linux ];
      unitConfig.RequiresMountsFor = bootPathBackup;
      serviceConfig = {
        PrivateDevices = "no";
        ReadWritePaths = bootPathBackup;
        RemainAfterExit = true;
      };
      script = ''
        eval $(findmnt -f -P --output source /boot)
        PARTUUID=$(find -L /dev/disk/by-partuuid -samefile $SOURCE | awk -F'/' '{print $NF}')
        BOOT_ORDER_MNT=$(efibootmgr | awk '/'$PARTUUID'/ {print $1}')
        BOOT_ORDER_CRT=$(efibootmgr | awk '/BootCurrent/ {print $2}')

        # is current boot mounted boot?
        if [ "''${BOOT_ORDER_MNT:4:4}" != "$BOOT_ORDER_CRT" ]; then
          efibootmgr -o "''${BOOT_ORDER_MNT:4:4}"
          exit 7
        fi

        GEN_BOOT="$(realpath /run/booted-system)"
        GEN_SYSTEM="$(realpath /nix/var/nix/profiles/system)"

        # only backup if it is really the latest generation beeing used
        if [ "$GEN_BOOT" != "$GEN_SYSTEM" ]; then
          exit 23
        fi

        rsync -rltv --delete /boot/ ${bootPathBackup}/
        umount ${bootPathBackup}
      '';
    };
    timer = lib.mkForce {};
  };
}
