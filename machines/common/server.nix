{ ... }:

{
  imports = [
    ../../hardware/filesystem-single-disk.nix
    ../../nix/build-cache
    ../../services/openssh/backup.nix
    ../../services/wireguard/server.nix
    ../../system/impermanence/server.nix
  ];
}
