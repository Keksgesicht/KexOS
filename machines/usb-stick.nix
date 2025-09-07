{ ... }:

{
  # Define your hostname
  networking.hostName = "usb-stick";

  imports = [
    ./common
    ./common/desktop.nix
    ../hardware/filesystem-single-disk.nix
    ../hardware/laptop/tuxedo.nix
    ../nix/build-cache/client.nix
  ];

  fileSystems."/boot".device = "/dev/disk/by-uuid/6E49-4B18";
  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/1269b931-af7a-4207-a424-3108ebb2fa72";
  };

  boot.initrd.availableKernelModules = [
    "usb_storage"
  ];
}
