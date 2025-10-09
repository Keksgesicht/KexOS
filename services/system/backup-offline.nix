{ pkgs, lib, ... }:

let
  pkg-bck-off = pkgs.callPackage ../../packages/backup-offline.nix {};
in
{
  fileSystems."/mnt/backup/usb/data" = {
    device = "/dev/mapper/usb-backup";
    fsType = "btrfs";
    options = [ "noauto" ];
  };

  KexOS.service = {
    "backup-offline" = {
      service = {
        stopIfChanged = false;
        restartIfChanged = false;
        description = "Offline Backup Job over USB";
        bindsTo = [ "mnt-backup-usb-data.mount" ];
        path = with pkgs; [ rsync util-linux ];
        unitConfig.RequiresMountsFor = "/mnt/backup/usb/data";
        serviceConfig = {
          Type = "exec";
          ExecStart = "${pkg-bck-off}/bin/backup-offline.sh";
          ReadWritePaths = "/mnt/backup/usb";
          InaccessiblePaths = lib.mkForce [];
        };
      };
      timer = lib.mkForce {};
    };
    # similar to backup-download
    "backup-upload" = {
      service = {
        stopIfChanged = false;
        restartIfChanged = false;
        after = [ "podman-pihole.service" ];
        description = "Upload Backups over SSH tunnel via RSYNC";
        path = with pkgs; [ gnutar gzip openssh rsync ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkg-bck-off}/bin/backup-upload.sh";
          ProtectHome = "no";
          TemporaryFileSystem = [
            "/etc:ro" "/home:ro" "/run/user:ro"
            "/root"
          ];
          BindReadOnlyPaths = [
            "/etc/ssh/ssh_config"
            "/root/.config/ssh"
            "/root/.secrets/ssh"
          ];
          InaccessiblePaths = lib.mkForce [];
        };
      };
      timer.timerConfig.OnCalendar = "*-*-* 07:07:07";
    };
  };
}
