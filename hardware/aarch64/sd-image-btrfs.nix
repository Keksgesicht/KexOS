{ options, config, pkgs, lib, modulesPath, ssd-mnt, hdd-mnt, ... }:

# inspired by https://github.com/n8henrie/nixos-btrfs-pi
let
  str = lib.strings;
  forEach = lib.lists.forEach;

  ubootBtrfs = (oldAttrs: {
    extraConfig = ''
      CONFIG_CMD_BTRFS=y
      CONFIG_ZSTD=y
    '';
  });

  subvolList = [ "boot" "etc" "home" "mnt-array" "nix" "var" ];
  subvolStr = (s: str.concatMapStrings (v: s + v) subvolList);
  rootfsImage = options.sdImage.rootImage.default;
  btrfsImage = rootfsImage.overrideAttrs (final: prev: {
    buildCommand = str.concatLines (forEach
      (str.splitString "\n" prev.buildCommand) (line:
        if (str.hasInfix "mkfs.btrfs" line)
        then "mkdir -p " + (subvolStr " ./rootImage/")
           + "\n" + line + (subvolStr " --subvol ")
        else line
      )
    );
  });

  rootDev = "/dev/disk/by-label/NIXOS_SD";
  btrfsOpts = {
    device = lib.mkForce rootDev;
    fsType = "btrfs";
    options = [
      "compress=zstd:3"
      "noatime" "discard=async"
      "ssd_spread" "autodefrag"
    ];
  };
in
{
  imports = [
    # nix build -L .'#'nixosConfigurations."cookiepi".config.system.build.sdImage
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  nixpkgs.overlays = [ (self: super: {
    ubootRaspberryPi3_64bit = super.ubootRaspberryPi3_64bit.overrideAttrs ubootBtrfs;
    ubootRaspberryPi4_64bit = super.ubootRaspberryPi4_64bit.overrideAttrs ubootBtrfs;
  }) ];

  sdImage = {
    compressImage = false;
    rootFilesystem = "${pkgs.path}/nixos/lib/make-btrfs-fs.nix";
    rootImage = btrfsImage;
  };

  boot = {
    kernelParams = [
      "rootwait"
      "root=${rootDev}"
      "rootfstype=btrfs"
      "rootflags=subvol=root" # see impermanence
    ];
    initrd.kernelModules = [ "btrfs" "zstd" ];
  };

  # see fileystem-single-disk and impermanence
  fileSystems = {
    "/boot" = btrfsOpts // {
      fsType = lib.mkForce "btrfs";
      options = lib.mkForce (btrfsOpts.options ++ [ "subvol=boot" ]);
    };
    "/boot/firmware" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "vfat";
      options =  [ "umask=0077" "shortname=winnt" ];
    };
    "/" = btrfsOpts // { fsType = lib.mkForce "btrfs"; };
    "/nix" = btrfsOpts;
    "${hdd-mnt}" = btrfsOpts;
    "${ssd-mnt}" = btrfsOpts;
  };
}
