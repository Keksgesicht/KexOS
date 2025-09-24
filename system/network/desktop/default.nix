{ config, pkgs, username, ... }:

let
  hn = config.networking.hostName;
in
{
  imports = [
    ../.
    ../network-manager
    ./certs.nix
    ./firewall.nix
    ./hosts.nix
    ./secrets.nix
  ];

  users.users."${username}".extraGroups = [ "networkmanager" ];

  # Enable networking via NetworkManager
  networking.networkmanager = {
    # randomize IP and MAC addresses
    # https://fedoramagazine.org/randomize-mac-address-nm/
    # https://blogs.gnome.org/thaller/2016/08/26/mac-address-spoofing-in-networkmanager-1-4-0/
    wifi = {
      scanRandMacAddress = true;
      macAddress = "random";
    };
    ethernet.macAddress = "stable";
    connectionConfig = {
      "connection.stable-id" = ''''${CONNECTION}/''${BOOT}'';
    };

    dispatcherScript = if (hn == "cookieclicker") then {
      "50-no-ddns-vpn".packages = with pkgs; [ gnugrep iproute2 ];
    } else {};

    plugins = [
      pkgs.networkmanager-openconnect # VPN to university
    ];
  };
}
