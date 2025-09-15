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
    ../system/network/server/lan.nix
  ];

  KexOS.variables.rpi_version = 3;
}
