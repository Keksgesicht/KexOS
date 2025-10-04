{ ... }:

{
  imports = [
    ../../desktop/environment.nix
    ../../desktop/my-user.nix
    ../../development/base-devel.nix
    ../../hardware
    ../../hardware/common/filesystem-single-disk.nix
    ../../hardware/common/swap.nix
    ../../nix
    ../../services/system/backup-snapshot.nix
    ../../system
  ];
}
