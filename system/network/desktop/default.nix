{ config, pkgs, lib, isDesktop, myDomain, lan-subnet-v4, vpn-subnet-v4, ... }:

let
  my-functions = (import ../../../nix/my-functions.nix lib);

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

  allowedPortsSSH = {
    allowedTCPPorts = if config.services.openssh.enable
      then [ 22 ]
      else [];
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

  allowedPortsVPNuser = {
    allowedTCPPortRanges = [
      { from = 10000; to = 65535; } # nearly all user ports
    ];
    allowedUDPPortRanges = [
      { from = 10000; to = 65535; } # nearly all user ports
    ];
  };
in
with my-functions;
{
  imports = [
    ../.
    ../IPv6/network-manager.nix
  ];

  # symlinks for all certificates
  environment.etc =
  let
    cert-dir = "ssl/certs";
    cacert-dir = "${pkgs.cacert.unbundled}/etc/${cert-dir}";
    cert-set = builtins.listToAttrs
    ( map
      ( e:
        let
          eCert = lib.removePrefix "${cacert-dir}/" e;
          certName = builtins.head (builtins.split ":" eCert) + ".crt";
        in
        {
          name = "${cert-dir}/unbundled/${certName}";
          value = {
            source = e;
          };
        }
      )
      (listFilesRec cacert-dir)
    );
  in
  cert-set // {
    "ssl/certs/cacert-unbundled".source = cacert-dir;
  };

  # Enable networking via NetworkManager
  networking.networkmanager = {
    enable = true;

    # randomize IP and MAC addresses
    # https://fedoramagazine.org/randomize-mac-address-nm/
    # https://blogs.gnome.org/thaller/2016/08/26/mac-address-spoofing-in-networkmanager-1-4-0/
    wifi = {
      scanRandMacAddress = true;
      macAddress = "random";
    };
    ethernet.macAddress = "stable";
    connectionConfig = {
      "connection.stable-id" = "\${CONNECTION}/\${BOOT}";
    };

    dispatcherScripts = []
      ++ lib.optionals (config.networking.hostName == "cookieclicker") [ {
        type = "basic";
        source = pkgs.writers.writeBash "50-no-ddns-vpn" (''
          export PATH=$PATH
        '' + (builtins.readFile ../../../files/linux-root/etc/NetworkManager/dispatcher.d/50-no-ddns-vpn));
      } ];
  };

  systemd = {
    services = {
      "NetworkManager-wait-online" =
        # https://askubuntu.com/questions/1018576/what-does-networkmanager-wait-online-service-do
        if (isDesktop) then
          { enable = lib.mkForce false; }
        else {};
    };
  };

  # enable mDNS responder
  services.avahi = {
    enable = true;
    openFirewall = false;
  };

  # firewall
  networking.firewall = {
    enable = true;

    interfaces =
      if (config.networking.hostName == "cookieclicker") then {
        "enp4s0" = lib.mkMerge [
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
        "wlp5s0" = allowedPortsShared;
        #"tap0" = allowedPortsVPNuser;
      }
      else if (config.networking.hostName == "cookiethinker") then {
        "enp2s0" = allowedPortsShared;
        "wlo1" = {
          allowedUDPPorts = [ 5353 ];
        } // allowedPortsSSH;
      }
      else {};
  };

  networking.hosts = {
    # multicast (from Fedora)
    "ff02::1" = [ "ip6-allnodes" ];
    "ff02::2" = [ "ip6-allrouters" ];

    # Router
    "${lan-subnet-v4}.1" = [ "fritz.box" ];

    # VPN devices
    "${vpn-subnet-v4}.2"   = [ "cookiepi.keksgesicht.internal" ];
    "${vpn-subnet-v4}.103" = [ "rpi.pihole.internal" ];

    # LAN devices
    "${lan-subnet-v4}.147" = [ "cookiethinker.${myDomain}" ];
    "${lan-subnet-v4}.230" = [ "temp.host.internal" ];

    # TUDa ESA-Infrastruktur (sshuttle)
    "10.5.0.38" = [ "gitlab.esa.informatik.tu-darmstadt.de" ];
  };
}
