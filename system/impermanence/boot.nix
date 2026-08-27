{ config, pkgs, lib, ssd-mnt, ssd-name, ... }:

let
  ssd-fs-cfg = config.fileSystems."${ssd-mnt}";
  ssd-fs-opt-str = (lib.concatStringsSep "," ssd-fs-cfg.options);
  biss = config.boot.initrd.systemd.services;

  tmp-mnt = "/mnt-${ssd-name}";
in
{
  options."setup-impermance-root-volume" = {
    backupCommands = lib.mkOption {
      type = lib.types.str;
      default = ''
        mkdir -p $BACKUP_DIR
        for sv in $(list_backups); do
          delete_subvolumes $sv
        done
        if [ -e $TMP_ROOT_DIR ]; then
          mv $TMP_ROOT_DIR $BACKUP_DIR/$(date +%Y%m%d_%H%M%S)
        fi
      '';
      description = ''
        The part of the script that moves the existing root volume to the backups
        and deletes all old enough root volumes in the backups.
      '';
    };
    initRoot = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        The part of the script after a new root volume was created.
        Useful to initialize the root volume with additional files.
      '';
    };
  };

  config.boot.initrd.systemd = {
    enable = true;
    storePaths = biss."setup-impermanence-root-volume".path;
    services."setup-impermanence-root-volume" = {
      enable = (ssd-fs-cfg.fsType == "btrfs");
      description = "Setup new subvolume for /";
      unitConfig.DefaultDependencies = false; # allow running it before root mount
      wantedBy = [ "initrd-root-device.target" ];
      after    = [ "initrd-root-device.target" ];
      before     = [ "initrd-root-fs.target" "sysroot.mount" ];
      requiredBy = [ "initrd-root-fs.target" "sysroot.mount" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      path = with pkgs; [
        btrfs-progs coreutils findutils
        tzdata util-linux
      ];
      environment = {
        TZ = config.time.timeZone;
        TZDIR = "${pkgs.tzdata}/share/zoneinfo";

        TMP_MNT = "${tmp-mnt}";
        TMP_ROOT_DIR = "${tmp-mnt}/root";
        BACKUP_DAYS = "3";
        BACKUP_DIR = "${tmp-mnt}/backup_${ssd-name}/boot/root";
      };
      script = ''
        list_backups() {
          bck_dirs=$(realpath $BACKUP_DIR/* | sort -r | tail -n +$BACKUP_DAYS)
          [ -z "$bck_dirs" ] && return
          find $bck_dirs -maxdepth 0 -mtime +$BACKUP_DAYS
        }
        delete_subvolumes() {
            IFS=$'\n'
            set +e
            for sv in $(btrfs subvolume list -o "$1" | cut -d' ' -f9); do
                btrfs subvolume delete --recursive "$TMP_MNT/$sv"
            done
            btrfs subvolume delete $1
            set -e
        }

        mkdir -p $TMP_MNT
        mount -t ${ssd-fs-cfg.fsType} -o ${ssd-fs-opt-str} \
          ${ssd-fs-cfg.device} $TMP_MNT

        # if not exist, initialize machine-id
        if ! [ -f "$TMP_MNT/etc/machine-id" ]; then
          uuidgen | md5sum | cut -f1 -d ' ' > "$TMP_MNT/etc/machine-id"
        fi
      '' + config."setup-impermance-root-volume".backupCommands + ''
        if ! [ -d "$TMP_ROOT_DIR" ]; then
          btrfs subvolume create $TMP_ROOT_DIR
        fi
      '' + config."setup-impermance-root-volume".initRoot + ''
        umount $TMP_MNT
        exit 0
      '';
    };
  };
}
