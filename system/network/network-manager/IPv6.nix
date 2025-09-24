{ config, pkgs, ... }:

let
  pub6ds = config.networking.networkmanager.dispatcherScript."50-public-ipv6";
in
{
  networking.networkmanager.dispatcherScript = {
    "50-home-ipv6-ULU".packages = with pkgs; [ gnugrep iproute2 ];
    "50-public-ipv6".packages = with pkgs; [
      coreutils gawk iproute2 procps util-linux
    ];
  };

  systemd = {
    services = {
      "NetworkManager-dispatcher" = {
        serviceConfig.TimeoutStopSec = 13;
      };
      "ipv6-prefix-update" = {
        description = "IPv6 prefix check and suffix updater";
        serviceConfig.ExecStart = pub6ds.output.script + " "
          + "${pub6ds.variables.MY_IFLINK} prefix";
      };
    };
    timers = {
      "ipv6-prefix-update" = {
        description = "regular IPv6 prefix update check";
        timerConfig = {
          OnStartupSec = "123sec";
          OnUnitInactiveSec = "1234sec";
        };
        wantedBy = [ "timers.target" ];
      };
    };
  };
}
