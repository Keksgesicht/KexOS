{ config, lib, ifLan, ifWlan, ... }:

let
  hn = config.networking.hostName;

  allowVPNaccess = false;

  allowedPortsShared = {
    allowedTCPPorts = [
          53 # DNS
    ];
    allowedUDPPorts = [
          53 # DNS
          67 # DHCP server
        5353 # mDNS by avahi
    ];
  };
  allowedPortsCCbase = {
    allowedTCPPorts = [
         53 # DNS (Pihole)
         80 # HTTP (swag / lancache)
        443 # HTTPS (swag)
    ];
    allowedUDPPorts = [
         53 # DNS (Pihole)
        443 # HTTP3 (swag)
       5353 # mDNS by avahi
    ];
    allowedTCPPortRanges = [
      { from = 22200; to = 22299; } # free choice
    ];
    allowedUDPPortRanges = [
      { from = 22200; to = 22299; } # free choice
    ];
  };
  allowedPortsCCextra = {
    allowedTCPPorts = [
         22 # OpenSSH
       2053 # DNS (unbound)
    ];
    allowedUDPPorts = [
       2053 # DNS (unbound)
    ];
  };

  allowedPortsKDEconnect = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  # https://help.steampowered.com/en/faqs/view/46BD-6BA8-B012-CE43
  allowedPortsSteam = {
    allowedTCPPorts = [ 27040 ];
    allowedUDPPortRanges = [ { from = 27031; to = 27036; } ];
  };

  allowedPortsVPNuser = rec { # nearly all user ports
    allowedTCPPortRanges = [ { from = 10000; to = 65535; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
in
{
  # enable mDNS responder
  services.avahi = {
    enable = true;
    openFirewall = false;
  };

  # firewall
  networking.firewall = {
    enable = true;

    interfaces =
      if (hn == "cookieclicker") then {
        "br-home" = lib.mkMerge [
          allowedPortsCCbase
          allowedPortsCCextra
          allowedPortsKDEconnect
          allowedPortsSteam
        ];
        "wg-server" = lib.mkMerge [
          allowedPortsCCbase
          allowedPortsCCextra
          allowedPortsKDEconnect
          allowedPortsSteam
        ];
        "podman-server" = allowedPortsCCbase;
        "enp6s0" = allowedPortsShared;
        "${ifWlan}" = allowedPortsShared;
        "tap0" = if allowVPNaccess then allowedPortsVPNuser else {};
      }
      else if (config.networking.hostName == "cookiethinker") then {
        "wg-laptop" = { allowedTCPPorts = [ 22 ]; };
        "${ifLan}" = allowedPortsShared;
        #"${ifWlan}" = { allowedUDPPorts = [ 5353 ]; };
      }
      else {};
  };
}
