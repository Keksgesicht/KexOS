{ self, config, pkgs, myDomain, secrets-dir, ... }:

let
  hn = config.networking.hostName;
  pub6ds = config.networking.networkmanager.dispatcherScript."50-public-ipv6";
in
{
  systemd = {
    services."hetzner-ddns" = {
      path = with pkgs; [ bash curl gawk gnused iproute2 jq util-linux ];
      environment = pub6ds.variables // {
        TTL =
          if (hn == "cookieclicker") then "300"
          else "1000";
        records =
          if (hn == "cookieclicker") then "tw.host"
          else if (hn == "cookieflyer") then "pi.host"
          else "";
        domain = myDomain;
      };
      serviceConfig = {
        EnvironmentFile = "${secrets-dir}/keys/services/ddns/HETZNER_APIKEY";
        ExecStart = "${self}/files/scripts/hetzner-ddns.sh";
      };
    };
    timers."hetzner-ddns" = {
      timerConfig = {
        OnStartupSec = "123sec";
        OnUnitInactiveSec = "1234sec";
      };
      wantedBy = [ "timers.target" ];
    };
  };
}
