{ ... }:

{
  imports = [
    ./boot-backup.nix
    ./filesystem.nix
    ./services.nix
    ./sysctl.nix
    ./usb-docking-station.nix
    ../services/emulation.nix
  ];
}
