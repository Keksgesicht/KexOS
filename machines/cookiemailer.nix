{ lib, vpn-subnet-v4, vpn-ip-suf, ... }:

{
  # Define your hostname
  networking.hostName = "cookiemailer";

  imports = [
    ../desktop/environment.nix
    ../desktop/my-user.nix
    ../hardware
    ../hardware/filesystem-single-disk.nix
    ../hardware/hetzner.nix
    ../development/base-devel.nix
    ../nix
    ../nix/build-cache
    ../nix/secrets-pkg.nix
    ../nix/version-23-05.nix
    ../services/containers/mailcow.nix
    ../services/system/backup-snapshot.nix
    ../services/system/rsyncd.nix
    ../services/system/wireguard/server.nix
    ../system
    ../system/impermanence
    ../system/impermanence/server.nix
    ../system/openssh/backup.nix
    ../system/network/server/hetzner.nix
  ];

  services.nix-serve.bindAddress = lib.mkForce "${vpn-subnet-v4}.${vpn-ip-suf}";
}
