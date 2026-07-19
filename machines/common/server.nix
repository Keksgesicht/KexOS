{ ... }:

{
  imports = [
    ../../nix/build-cache
    ../../services/openssh/backup.nix
    ../../services/wireguard/server.nix
    ../../system/impermanence/server.nix
    ../../system/server.nix
  ];
}
