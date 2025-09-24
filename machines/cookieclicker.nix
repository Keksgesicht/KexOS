{ ... }:

{
  # Define your hostname
  networking.hostName = "cookieclicker";

  imports = [
    ./common
    ./common/desktop.nix
    ../desktop/gaming.nix
    ../development
    ../hardware/tower
    ../nix/build-cache
    ../services/containers/lancache.nix
    ../services/containers/pihole.nix
    ../services/containers/proxy.nix
    ../services/containers/unbound.nix
    ../services/system/auto-suspend.nix
    ../services/system/backup-download.nix
    ../services/system/backup-offline.nix
    ../services/system/dyndns.nix
    ../services/system/fancontrol.nix
    ../services/wireguard/server.nix
    ../system/network/network-manager/IPv6.nix
    ../system/network/wireless.nix
  ];
}
