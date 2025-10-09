{ config, pkgs, lib, ... }:

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

  KexOS.service."ipv6-prefix-update" = {
    service = {
      description = "IPv6 prefix check and suffix updater";
      onSuccess = [ "hetzner-ddns.service" ];
      serviceConfig = {
        ExecStart = pub6ds.output.script + " "
          + "${pub6ds.variables.MY_IFLINK} prefix";
        PrivateDevices = "no";
        TimeoutStopSec = 13;
      };
    };
    timer = {
      description = "regular IPv6 prefix update check";
      after = lib.mkForce [];
      timerConfig = lib.mkForce {
        OnStartupSec = "123sec";
        OnUnitInactiveSec = "1234sec";
      };
    };
  };
}
