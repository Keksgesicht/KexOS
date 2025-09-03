{ ... }:

{
  imports = [
    ../../hardware/filesystem-single-disk.nix
    ../../nix/build-cache
    ../../services/system/wireguard/server.nix
    ../../system/impermanence/server.nix
    ../../system/openssh/backup.nix
  ];
}
