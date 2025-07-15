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

  # https://wiki.archlinux.org/title/sysctl
  # https://man7.org/linux/man-pages/man5/proc.5.html
  boot.kernel.sysctl = {
    # reboot on panic after x seconds
    "kernel.panic" = 3;

    # https://www.jethrocarr.com/2019/01/05/automatically-restarting-gnu-linux-hosts-upon-hung-storage/
    "kernel.hung_task_panic" = 1;

    # https://forum.proxmox.com/threads/vm-blocked-due-to-hung_task_timeout_secs.22488/
    # https://blog.ronnyegner-consulting.de/2011/10/13/info-task-blocked-for-more-than-120-seconds/comment-page-1/
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
  };
}
