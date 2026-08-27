{ config, pkgs, lib, home-dir, ssd-mnt, ssd-name, hdd-mnt, hdd-name, ... }:

let
  inherit (config.KexOS.variables) data-dir;
  cleanup-pkg = pkgs.callPackage ../../packages/files-cleanup.nix {};
  locate-path = "/var/cache/locatedb";
  inherit (config.KexOS.service."dummy".service) serviceConfig;
in
{
  KexOS.service = {
    "files-cleanup" = {
      service = {
        description = "unCookie Cleanup";
        path = with pkgs; [ gawk moreutils plocate podman ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${cleanup-pkg}/bin/cleanup.sh";
          ProtectHome = false;
          ReadOnlyPaths = "/";
          ReadWritePaths = [
            "${home-dir}/nixos-config"
            "${data-dir}"
            "-${hdd-mnt}/appdata2/nextcloud/web"
            "-${ssd-mnt}/appdata/ddns"
            "-/var/lib/containers/storage"
          ];
          InaccessiblePaths = lib.filter (x: x != "${ssd-mnt}/var")
            serviceConfig.InaccessiblePaths.content ++ [ "/run/user" "/root" ];
        };
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
    "update-locatedb" = {
      service = {
        # script in unit above needs updatedb/locate
        after = [
          "mnt-${ssd-name}.mount"
          "mnt-${hdd-name}.mount"
        ];
        serviceConfig = {
          ProtectHome = lib.mkForce "no";
          InaccessiblePaths = lib.mkForce [];
        };
      };
    };
  };

  # environment variable LOCATE_PATH does not seem to be used by `locate`
  systemd.tmpfiles.rules = [
    "L+ ${locate-path} - - - - ${ssd-mnt}${locate-path}"
    "d  ${ssd-mnt}/var/cache - - - - -"
  ];

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
