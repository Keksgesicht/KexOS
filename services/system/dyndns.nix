{ self, config, pkgs, lib, myDomain, secrets-dir, ... }:

let
  hn = config.networking.hostName;
  pub6ds = config.networking.networkmanager.dispatcherScript."50-public-ipv6";
in
{
  KexOS.service."hetzner-ddns" = {
    service = {
      after = [ "podman-pihole.service" ];
      path = with pkgs; [ bash curl gawk gnused iproute2 jq util-linux ];
      environment = pub6ds.variables // {
        TTL =
          if (hn == "cookieclicker") then "300"
          else "1000";
        records =
          if (hn == "cookieclicker") then "tw.host"
          else if (hn == "cookieflyer") then "fy.host"
          else if (hn == "cookiepi") then "pi.host"
          else "";
        domain = myDomain;
      };
      serviceConfig = {
        EnvironmentFile = "${secrets-dir}/keys/services/ddns/HETZNER_APIKEY";
        ExecStart = "${self}/files/scripts/hetzner-ddns.sh";
        PrivateDevices = "no";
      };
    };
    timer = {
      after = lib.mkForce [];
      timerConfig = lib.mkForce {
        OnStartupSec = "12sec";
        OnUnitInactiveSec = "4321sec";
      };
    };
  };
}
