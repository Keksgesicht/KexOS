{ pkgs, lib, ssd-mnt, ssd-name, hdd-mnt, hdd-name, nvm-mnt, nvm-name, ... }:

let
  ssd-numbers = [ 1 2 ];
  ssd-label   = "/dev/disk/by-label/${ssd-name}";
  ssd-keyfile = "/dev/disk/by-partuuid/c58965ae-8061-714c-94ef-11c57da14a63";

  hdd-numbers = [ 1 3 4 ];
  hdd-label   = "/dev/disk/by-label/${hdd-name}";
  hdd-keyfile = "/dev/disk/by-partuuid/3375b91e-8e21-7e46-ad42-fcdc11b8858a";

  nvm-numbers = [ 1 3 4 5 ];
  nvm-label   = "/dev/disk/by-label/${nvm-name}";
  nvm-keyfile = "/dev/disk/by-partuuid/7bf59cfb-f4ea-c047-84b0-8b7ac74d76a4";

  list2luksdev = builtins.listToAttrs (map (num:
    let
      n = toString num;
    in
    {
      name = "main${n}";
      value = {
        device = "${ssd-label}${n}";
        keyFile = ssd-keyfile;
        keyFileSize = 2048;
      };
    }
  ) ssd-numbers);

  inherit (lib.lists) forEach;
  list2crypttab = (name: label: keyfile: numbers: opts: forEach numbers (num:
    let
      n = toString num;
    in
    "${name}${n}  ${label}${n}  ${keyfile}  ${opts}"
  ));

  backup-boot = "/mnt/backup/boot";
in
{
  /*
   * fTPM not working under Linux
   * TEMPORARY SOLUTION (throwing away single drives without thinking should work and I can still use Wake on LAN)
   * find -L /dev/disk -samefile /dev/sdh2
   * dd status=progress bs=2048 if=/etc/nixos/secrets/keys/luks/main of=/dev/sdh2 seek=0
   */
  boot.initrd.luks.devices = list2luksdev;

  # https://www.freedesktop.org/software/systemd/man/latest/crypttab.html
  # nofail -> no Before=cryptsetup.target
  environment.etc."crypttab".text = builtins.concatStringsSep "\n" (
    (
      list2crypttab
      hdd-name hdd-label hdd-keyfile hdd-numbers
      "nofail,keyfile-size=2048"
    ) ++ [ "" ] ++ (
      list2crypttab
      nvm-name nvm-label nvm-keyfile nvm-numbers
      "nofail,keyfile-size=2048,discard"
    )
  );

  # https://www.freedesktop.org/software/systemd/man/latest/systemd-fstab-generator.html
  fileSystems =
  let
    fat-opts = [ "umask=0077" "shortname=winnt" ];
    bfs-opts = [ "compress=zstd:3" ];
    crypt-req = (disk: numbers: lib.lists.forEach numbers (num:
      let
        n = toString num;
      in
      "x-systemd.requires=systemd-cryptsetup@${disk}${n}.service"
    ));
  in
  {
    "/boot" = {
      device = "/dev/disk/by-uuid/F6A6-57AC";
      fsType = "vfat";
      options = fat-opts;
    };
    "/nix" = {
      device = ssd-label;
      fsType = "btrfs";
      options = bfs-opts ++ [ "subvol=nix" ];
      # implicit neededForBoot
    };

    "${ssd-mnt}" = {
      device = ssd-label;
      fsType = "btrfs";
      options = bfs-opts ++ [ "subvol=/" ];
      neededForBoot = true;
    };
    "${hdd-mnt}" = {
      device = hdd-label;
      fsType = "btrfs";
      options = [
        "compress-force=zstd:3"
        "subvol=/"
        "nofail" # no Before=local-fs.target
      ] ++ crypt-req hdd-name hdd-numbers;
    };
    "${nvm-mnt}" = {
      device = nvm-label;
      fsType = "btrfs";
      options = bfs-opts ++ [
        "subvol=/"
        "nofail" # no Before=local-fs.target
      ] ++ crypt-req nvm-name nvm-numbers;
    };

    "${backup-boot}" = { # other NVMe (see /boot)
      device = "/dev/disk/by-uuid/AD3C-E855";
      fsType = "vfat";
      options = fat-opts;
    };
    "/mnt/backup/USB/data" = {
      device = "/dev/mapper/usb-backup";
      fsType = "btrfs";
      options = [ "noauto" ];
    };
  };

  swapDevices = [
    {
      # random encryption will resetup the LUKS header
      # using by-partuuid should not change between system reboots or kernel updates
      device = "/dev/disk/by-partuuid/85439545-b3f4-f742-948f-e3a7190f5fc7";
      randomEncryption.enable = true;
      options = [ "nofail" ];
    }
  ];

  systemd.services = {
    "backup-boot" = {
      wantedBy = [ "user@1000.service" ];
      after = [ "user@1000.service" ];
      unitConfig.RequiresMountsFor = backup-boot;
      serviceConfig.RemainAfterExit = true;
      script = ''
        ${pkgs.coreutils}/bin/sleep 666s
        ${pkgs.rsync}/bin/rsync -rltv --delete /boot/ ${backup-boot}/
        ${pkgs.util-linux}/bin/umount ${backup-boot}
      '';
    };
  };
}
