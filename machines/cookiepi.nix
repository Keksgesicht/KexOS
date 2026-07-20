{ ... }:

{
  # Define your hostname
  networking.hostName = "cookiepi";

  imports = [
    ./common
    ./common/server.nix
    ../hardware/aarch64/RaspberryPi.nix
    ../hardware/services/baremetal.nix
    ../services/containers/pihole.nix
    ../services/containers/proxy.nix
    ../services/containers/unbound.nix
    ../services/system/dyndns.nix
    ../services/system/rsyncd.nix
    ../system/network/server/bridge.nix
  ];

  KexOS.variables.rpi_version = 3;

  sdImage = {
    firmwarePartitionID = "0x8b2f4f93";
    rootPartitionUUID = "aa26e441-701e-478f-95f5-8c23ddeb4049";
  };

  networking.firewall.allowedUDPPorts = [
    67    # DHCP
    5353  # mDNS
  ];
  virtualisation.oci-containers.containers."pihole".ports = [
    "67:67/udp"     # DHCP
    "5353:5353/udp" # mDNS
  ];
}
