{ pkgs, lib, data-dir, ssd-mnt, ssd-name, hdd-mnt, hdd-name, home-dir, ... }:

let
  cleanup-pkg = pkgs.callPackage ../../packages/files-cleanup.nix {};
  locate-path = "/var/cache/locatedb";
in
{
  KexOS.service."files-cleanup" = {
    service = {
      description = "unCookie Cleanup";
      path = with pkgs; [ gawk moreutils plocate podman ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${cleanup-pkg}/bin/cleanup.sh";
        ReadOnlyPaths = "/";
        ReadWritePaths = [
          "${home-dir}/nixos-config"
          "${data-dir}"
          "-${hdd-mnt}/appdata2/nextcloud/janb/files/.Calendar-Backup"
          "-${hdd-mnt}/appdata2/nextcloud/janb/files/.Contacts-Backup"
          "-${hdd-mnt}/appdata2/nextcloud/janb/files/InstantUpload/SignalBackup"
          "-${ssd-mnt}/appdata/ddns"
          "-/var/lib/containers/storage"
        ];
      };
      wants = [ "update-locatedb.service" ];
    };
    # cleanup after boot and repeat after 24h (if still running)
    timer = {
      description = "unCookie Cleanup Timer";
      after = lib.mkForce [
        "update-locatedb.service"
        "podman-nextcloud.service"
        "mnt-${ssd-name}.mount"
        "mnt-${hdd-name}.mount"
        "backup-snapshot@${ssd-name}.service"
        "backup-snapshot@${hdd-name}.service"
      ];
      timerConfig = lib.mkForce {
        OnStartupSec      = "7s";
        OnUnitInactiveSec = "1d";
      };
    };
  };

  systemd = {
    services = {
      # script in unit above needs updatedb/locate
      "update-locatedb".after = [
        "mnt-${ssd-name}.mount"
        "mnt-${hdd-name}.mount"
      ];
    };
    # environment variable LOCATE_PATH does not seem to be used by `locate`
    tmpfiles.rules = [
      "L+ ${locate-path} - - - - ${ssd-mnt}${locate-path}"
      "d  ${ssd-mnt}/var/cache - - - - -"
    ];
  };

  # script in unit above needs updatedb/locate
  services.locate = {
    enable = true;
    interval = "08:15";
    package = pkgs.plocate;
    output = "${ssd-mnt}${locate-path}";
    pruneNames = [
      # NixOS default
      # https://search.nixos.org/options?channel=unstable&show=services.locate.pruneNames
      ".bzr"
      ".cache"
      ".git"
      ".hg"
      ".svn"
      # my additional directory names
      "backup_${hdd-name}"
      "backup_${ssd-name}"
      "cache"
      "Cache"
      "CachedData"
      "CachedExtensions"
      "CachedExtensionVSIXs"
      "CachedProfilesData"
      "Code Cache"
      "DawnCache"
      "GPUCache"
      "GrShaderCache"
      "images-cache"
      "ShaderCache"
      "tabCache"
      "Trash"
    ];
  };
}
