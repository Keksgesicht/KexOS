{ pkgs, lan-subnet-v4, lan-ip-suf, ... }:

let
  nmsc-path = "linux-root/etc/NetworkManager/system-connections";
in
{
  imports = [
    ../.
    ../IPv6/network-manager.nix
  ];

  networking.networkmanager.enable = true;

  # Just excluding wireguard interfaces does not work with NetworkManager.
  # Thus, we disable it completly as our servers are locally self-contained.
  # https://askubuntu.com/questions/1018576/what-does-networkmanager-wait-online-service-do
  systemd.services."NetworkManager-wait-online".enable = false;

  environment.etc = {
    "NetworkManager/system-connections/lan.nmconnection" = {
      mode = "0600";
      source = pkgs.substituteAll {
        src       =  ../../../files + "/${nmsc-path}/server_lan.nmconnection";
        dnsserver = "${lan-subnet-v4}.${lan-ip-suf};172.23.53.1;";
        ipaddr    = "${lan-subnet-v4}.${lan-ip-suf}/24,${lan-subnet-v4}.1";
      };
    };
  };

  networking.firewall = rec {
    enable = true;
    allowedTCPPorts = [
         22 # OpenSSH
         53 # DNS (Pihole)
         80 # HTTP (swag / lancache)
        443 # HTTPS (swag)
       2053 # DNS (unbound)
    ];
    allowedUDPPorts = [
         53 # DNS (Pihole)
        443 # HTTP3 (swag)
       2053 # DNS (unbound)
    ];
    allowedTCPPortRanges = [ { from = 22200; to = 22299; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  networking.hosts = {
    # multicast (from Fedora)
    "ff02::1" = [ "ip6-allnodes" ];
    "ff02::2" = [ "ip6-allrouters" ];

    # Router
    "${lan-subnet-v4}.1" = [ "fritz.box" ];
  };
}
