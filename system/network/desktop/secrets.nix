{ self, config, pkgs, lib, secrets-pkg, username
, lan-subnet-v4, pod-subnet-v4, lan-ip-suf, ... }:

let
  cfgNetName = config.networking.hostName;

  nmsc-root = ../../../files;
  nmsc-path = "linux-root/etc/NetworkManager/system-connections";
  nmsc-data = "${secrets-pkg}/${nmsc-path}";

  nm-rf = (name: builtins.readFile "${nmsc-data}/${name}");
  nm-sub = (name: nm-cfg:
    let
      nm-src-path = nmsc-root + "/${nmsc-path}/${name}.nmconnection";
    in
    pkgs.replaceVars nm-src-path nm-cfg
  );
  nm-wifi = (no: uuid: dns:
    let
      nm-src-path = nmsc-root + "/${nmsc-path}/my_wlan.nmconnection";
    in
    {
      "NetworkManager/system-connections/wlan${no}.nmconnection" = {
        mode = "0600";
        enable = (cfgNetName == "cookiethinker");
        source = pkgs.replaceVars nm-src-path {
          inherit uuid;
          user = username;
          nmid = nm-rf "wlan${no}-ssid";
          ssid = nm-rf "wlan${no}-ssid";
          dns4 = (lib.strings.concatStringsSep ";" dns) + ";";
          wifi_sec = nm-rf "wlan${no}-wifi-sec";
        };
      };
    }
  );
in
{
  imports = [
    "${self}/nix/secrets-pkg.nix"
  ];

  environment.etc = {
    # network connections on all systems
    "NetworkManager/system-connections/TU_Darmstadt.nmconnection" = {
      mode = "0600";
      source = nm-sub "TU_Darmstadt" ({ username = nm-rf "TU_Darmstadt-username"; });
    };

    # network connections on tower
    "NetworkManager/system-connections/dmz.nmconnection" = {
      enable = (cfgNetName == "cookieclicker");
      mode = "0600";
      source = nm-sub "dmz" ({ macaddr = nm-rf "cookieclicker-dmz-macaddr"; });
    };
    "NetworkManager/system-connections/home_bridge.nmconnection" = {
      enable = (cfgNetName == "cookieclicker");
      mode = "0600";
      source = nm-sub "home_bridge" ({
        dnsserver = "${pod-subnet-v4}.53.1";
        ipaddr    = "${lan-subnet-v4}.${lan-ip-suf}/24";
        gateway   = "${lan-subnet-v4}.1";
      });
    };
    "NetworkManager/system-connections/home_lan.nmconnection" = {
      enable = (cfgNetName == "cookieclicker");
      mode = "0600";
      source = nm-sub "home_lan" ({ macaddr = nm-rf "cookieclicker-home-macaddr"; });
    };

    # network connections on laptop
    "NetworkManager/system-connections/eduroam.nmconnection" = {
      enable = (cfgNetName == "cookiethinker");
      mode = "0600";
      source = nm-sub "eduroam" ({ username = nm-rf "eduroam-username"; });
    };
    "NetworkManager/system-connections/nach_Hause_telefonieren.nmconnection" = {
      enable = (cfgNetName == "cookiethinker");
      mode = "0600";
      source = nm-sub "nach_Hause_telefonieren" ({
        hostname = nm-rf "vpn-nachHause-host";
        username = nm-rf "vpn-nachHause-user";
      });
    };
  }
  // (nm-wifi "00" "d6569f91-55ec-44df-80dd-833fe395b601" [ "${lan-subnet-v4}.25" ])
  // (nm-wifi "20" "6da41b6d-f5c0-45cf-87ec-4495c00091f9" [
    "${lan-subnet-v4}.220" "${lan-subnet-v4}.221"
  ])
  // (nm-wifi "21" "0fc01a29-ffc9-4d13-ba5f-0a52209b01b7" [
    "${lan-subnet-v4}.220" "${lan-subnet-v4}.221"
  ])
  ;
}
