{ lib, hdd-mnt, hdd-name, ... }:

{
  # Define your hostname
  networking.hostName = "cookieflyer";

  imports = [
    ./common
    ./common/server.nix
    ../hardware/laptop/server.nix
    ../hardware/services/baremetal.nix
    ../hardware/x86_64/desktop.nix
    ../services/system/files-cleanup.nix
    ../services/containers/nextcloud.nix
    ../services/containers/pihole.nix
    ../services/containers/proxy.nix
    ../services/containers/tandoor.nix
    ../services/containers/unbound.nix
    ../services/system/backup-hot.nix
    ../services/system/dyndns.nix
    ../system/network/server/lan.nix
  ];

  # required boot mounts
  fileSystems."/boot".device = "/dev/disk/by-uuid/4EFC-A800";
  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/867c7b32-c672-4660-aa54-57262ff3ebdf";
    crypttabExtraOpts = [ "tpm2-device=auto" ];
  };

  # delayed array mount
  environment.etc."crypttab".text = ''
    ${hdd-name} /dev/disk/by-uuid/92756ea5-50ee-456c-b760-5c997fcb54ad - nofail,tpm2-device=auto
  '';
  fileSystems."${hdd-mnt}" = {
    device = lib.mkForce "/dev/disk/by-label/${hdd-name}";
    options = [ # extend filesystem-single-disk.nix
      "nofail"
      "x-systemd.requires=systemd-cryptsetup@${hdd-name}.service"
    ];
  };
}
