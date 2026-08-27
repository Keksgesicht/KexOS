{ config, ssd-mnt, hdd-mnt, ... }:

let
  ssd-dev = "/dev/mapper/root";
  ssd-fs-cfg = config.fileSystems."${ssd-mnt}";
  bfs-opts = [ "compress=zstd:3" ];
in
{
  fileSystems = {
    "/" = {
      device = ssd-fs-cfg.device;
      fsType = ssd-fs-cfg.fsType;
      options = [
        "subvol=root"
        "compress=zstd:3"
        "nodev" "nosuid"
      ];
    };
    "/boot" = {
      fsType = "vfat";
      options = [ "umask=0077" "shortname=winnt" ];
    };
    "/nix" = {
      inherit (config.fileSystems."${ssd-mnt}") device;
      fsType = "btrfs";
      options = bfs-opts ++ [ "subvol=nix" ];
      # implicit neededForBoot
    };

    "${ssd-mnt}" = {
      device = ssd-dev;
      fsType = "btrfs";
      options = bfs-opts ++ [ "subvol=/" ];
      neededForBoot = true;
    };
    "${hdd-mnt}" = {
      device = ssd-dev;
      fsType = "btrfs";
      options = bfs-opts ++ [ "subvol=mnt-array" ];
    };
  };
}
