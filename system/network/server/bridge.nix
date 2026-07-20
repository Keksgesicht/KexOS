{ config, pkgs, lib, secrets-pkg
, lan-subnet-v4, lan-ip-suf, pod-subnet-v4, ... }:

let
  hn = config.networking.hostName;
  mode = "0600";

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
in
{
  imports = [
    ./lan.nix
  ];

  environment.etc = {
    "NetworkManager/system-connections/bridge.nmconnection" = {
      inherit mode;
      source = nm-sub "home_bridge" ({
        dnsserver = "${pod-subnet-v4}.53.1";
        ipaddr    = "${lan-subnet-v4}.${lan-ip-suf}/24";
        gateway   = "${lan-subnet-v4}.1";
      });
    };
    "NetworkManager/system-connections/lan.nmconnection" = {
      source = lib.mkForce (nm-sub "home_lan" ({
        macaddr = nm-rf "${hn}-home-macaddr";
      }));
    };
  };
}
