{ lib, modulesPath, ssd-mnt, hdd-mnt, ... }:

let
  hd = "/dev/sda";
  rp = "/dev/disk/by-label/hetzner-btrfs-root";
  mf = lib.mkForce;

  serviceConfig = {
    Nice = 13;
    OOMScoreAdjust = 123;
    #CPUAccounting = true;
    #CPUQuota = "80%";
  };
in
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = [
    "virtio_pci" "virtio_scsi"
  ];

  boot.loader.grub.devices = [ hd ];
  fileSystems = {
    "/boot".device      = "${hd}15";
    "/nix".device       = mf rp;
    "${hdd-mnt}".device = mf rp;
    "${ssd-mnt}".device = mf rp;
  };

  swapDevices = [ {
    device = "${ssd-mnt}/swapfile";
    randomEncryption.enable = true;
    options = [ "nofail" ];
    size = 6144;
  } ];

  nix.settings = {
    #cores = 1;
    #max-jobs = 1;
  };
  systemd.services = {
    "nix-daemon" = {
      inherit serviceConfig;
    };
    "nixos-upgrade" = {
      inherit serviceConfig;
    };
  };
}
