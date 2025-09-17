{ ... }:

{
  imports = [
    ../../desktop/environment.nix
    ../../desktop/my-user.nix
    ../../development/base-devel.nix
    ../../hardware
    ../../hardware/swap.nix
    ../../nix
    ../../services/system/backup-snapshot.nix
    ../../system
  ];
}
