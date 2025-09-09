{ pkgs, ...}:

let
  pkg-bck-off = pkgs.callPackage ../../packages/backup-offline.nix {};
in
{
  fileSystems."/mnt/backup/usb/data" = {
    device = "/dev/mapper/usb-backup";
    fsType = "btrfs";
    options = [ "noauto" ];
  };

  systemd = {
    services = {
      "backup-offline" = {
        description = "Offline Backup Job over USB";
        bindsTo = [ "mnt-backup-usb-data.mount" ];
        path = with pkgs; [ rsync util-linux ];
        unitConfig = {
          RequiresMountsFor = "/mnt/backup/usb/data";
        };
        serviceConfig = {
          Type = "exec";
          ExecStart = "${pkg-bck-off}/bin/backup-offline.sh";

          ProtectProc  = "invisible";
          PrivateTmp   = "yes";
          ProtectHome  = "yes";
          ProtectClock = "yes";

          ReadOnlyPaths  = "/";
          ReadWritePaths = "/mnt/backup/usb";
        };
      };
      # similar to backup-download
      "backup-upload" = {
        description = "Upload Backups over SSH tunnel via RSYNC";
        path = with pkgs; [ gnutar gzip openssh rsync ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkg-bck-off}/bin/backup-upload.sh";

          ProtectProc    = "invisible";
          PrivateTmp     = "yes";
          ProtectClock   = "yes";
          PrivateDevices = "yes";

          ReadOnlyPaths = "/";
          BindReadOnlyPaths = "/etc/ssh/ssh_config";
          TemporaryFileSystem = [
            "/etc:ro"
            "/root/.cache"
          ];
        };
      };
    };

    timers = {
      "backup-upload" = {
        timerConfig = {
          OnCalendar = "*-*-* 07:07:07";
          RandomizedDelaySec = "42 min";
          Persistent = true;
        };
        wantedBy = [ "timers.target" ];
      };
    };
  };
}
