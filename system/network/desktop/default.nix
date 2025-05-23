{ config, pkgs, lib, ... }:

{
  imports = [
    ../.
    ./certs.nix
    ./firewall.nix
    ./hosts.nix
    ./secrets.nix
  ];

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

  # https://askubuntu.com/questions/1018576/what-does-networkmanager-wait-online-service-do
  systemd.services."NetworkManager-wait-online".enable = false;
}
