{ lib, vpn-subnet-v4, vpn-ip-suf, ... }:

{
  # Define your hostname
  networking.hostName = "cookiemailer";

  imports = [
    ./common
    ./common/server.nix
    ../hardware/hetzner.nix
    ../services/containers/mailcow.nix
    ../services/system/rsyncd.nix
    ../system/network/server/hetzner.nix
  ];

  services.nix-serve.bindAddress = lib.mkForce "${vpn-subnet-v4}.${vpn-ip-suf}";
}
