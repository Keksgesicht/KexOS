{ lib, ... }:

{
  # Define your hostname
  networking.hostName = "cookiethinker";

  imports = [
    ./common
    ./common/desktop.nix
    ../hardware/laptop/tuxedo.nix
    ../hardware/laptop/usb-docking-station.nix
    ../hardware/office/scanner.nix
    ../nix/build-cache/client.nix
    ../services/wireguard/client.nix
  ];

  # filesystem extras
  fileSystems."/boot".device = "/dev/disk/by-uuid/90CE-7A63";
  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/c720b152-baf0-4336-bb04-83f01857cfab";
    crypttabExtraOpts = [ "tpm2-device=auto" ];
    bypassWorkqueues = true;
  };

  # why does /boot grow faster on my laptop? tower uses 1G too.
  boot.loader.systemd-boot.configurationLimit = lib.mkForce 10;
}
