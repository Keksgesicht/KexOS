{ ... }:

{
  imports = [
    ../../desktop
    ../../development
    ../../hardware/services/baremetal.nix
    ../../hardware/x86_64/desktop.nix
    ../../services/system/files-cleanup.nix
    ../../system/containers/podman.nix
    ../../system/network/desktop
  ];
}
