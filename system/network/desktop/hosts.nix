{ myDomain, lan-subnet-v4, vpn-subnet-v4, ... }:

{
  networking.hosts = {
    # multicast (from Fedora)
    "ff02::1" = [ "ip6-allnodes" ];
    "ff02::2" = [ "ip6-allrouters" ];

    # VPN devices
    "${vpn-subnet-v4}.102" = [ "cookiethinker.${myDomain}" ];
    "${vpn-subnet-v4}.103" = [ "rpi.pihole.internal" ];

    # LAN devices
    "${lan-subnet-v4}.1"   = [ "fritz.box" ]; # Router
    "${lan-subnet-v4}.230" = [ "temp.host.internal" ];

    # TUDa ESA-Infrastruktur (sshuttle)
    "10.5.0.38" = [ "gitlab.esa.informatik.tu-darmstadt.de" ];
  };
}
