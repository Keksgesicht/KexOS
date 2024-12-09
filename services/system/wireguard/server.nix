{ config, pkgs, lib, secrets-pkg, secrets-dir, myDomain, ... }:

let
  hn = config.networking.hostName;

  wg-path-data = "${secrets-pkg}/wireguard";
  wg-path-keys = "${secrets-dir}/keys/wireguard";

  wg-pubkey-path = (name:
    lib.removeSuffix "\n" (builtins.readFile "${wg-path-data}/public/${name}")
  );

  wg-nat = (ipv4: ipv6: port: ad:
    let
      iptbl4 = "${pkgs.iptables}/bin/iptables";
      iptbl6 = "${pkgs.iptables}/bin/ip6tables";
      logger = "${pkgs.util-linux}/bin/logger";
      nat-log =
        if (ad == "-A") then "started"
        else if (ad == "-D") then "stopped"
        else "unknown";
    in
    ''
      ${iptbl4} ${ad} FORWARD -i wg-server -j ACCEPT
      ${iptbl4} -t nat ${ad} POSTROUTING -s ${ipv4} -o ${port} -j MASQUERADE
      ${iptbl6} ${ad} FORWARD -i wg-server -j ACCEPT
      ${iptbl6} -t nat ${ad} POSTROUTING -s ${ipv6} -o ${port} -j MASQUERADE
      ${logger} -t wireguard "Tunnel WireGuard (wg-server) ${nat-log}"
    ''
  );

  wg-client = (name: pubName: preName: suf4: suf6:
  let
    pubKeyName = if (pubName != "") then pubName else name;
    preKeyName = if (preName != "") then preName else pubKeyName;
  in
  {
    inherit name;
    publicKey = (wg-pubkey-path pubKeyName);
    presharedKeyFile = "${wg-path-keys}/shared/${preKeyName}";
    allowedIPs = [
      "192.168.176.${suf4}/32"
      "fd00:2307::${suf6}/128"
    ];
  });

  wg-client-handy = (host:
    wg-client "handy" "handy-${host}" "" "101" "10:1"
  );
  wg-client-laptop = wg-client "cookiethinker" "" "" "102" "10:2";
  wg-rpi = wg-client "rpi" "" "cookiepi-rpi" "103" "10:3";

  wg-clicker-pi = (wg-client "cookiepi" "" "cookiepi-cookieclicker" "2" "2") // {
    endpoint = "25.host.${myDomain}:22243";
    dynamicEndpointRefreshSeconds = 1000;
    allowedIPs = [
      "192.168.176.0/24"
      "fd00:2307::/64"
    ];
  };
  wg-pi-clicker = (wg-client "cookieclicker" "" "cookiepi-cookieclicker" "1" "1");

  wg-server = (name: suf4: suf6: iface: listenPort: extPeers:
    let
      ipv4 = "192.168.176.${suf4}/24";
      ipv6 = "fd00:2307::${suf6}/64";
    in
    {
      "wg-server" = {
        ips = [ ipv4 ipv6 ];
        privateKeyFile = "${wg-path-keys}/private/${name}";
        postSetup = (wg-nat ipv4 ipv6 iface "-A");
        postShutdown = (wg-nat ipv4 ipv6 iface "-D");
        inherit listenPort;
        peers = [
          (wg-client-handy name)
          wg-client-laptop
        ] ++ extPeers;
      };
    }
  );
in
{
  imports = [
    ../../../nix/secrets-pkg.nix
  ];

  networking.wireguard.interfaces =
    if (hn == "cookieclicker") then
      wg-server "cookieclicker" "1" "1" "enp4s0" 22223 [
        wg-clicker-pi
      ]
    else if (hn == "cookiepi") then
      wg-server "cookiepi" "2" "2" "enp0s31f6" 22243 [
        wg-pi-clicker
        wg-rpi
      ]
    else {}
  ;

  systemd.services = if (hn == "cookieclicker") then {
    # VPN should wait for finished DNS setup
    "wireguard-wg-server-peer-cookiepi-refresh" = {
      after = [ "podman-pihole.service" ];
      preStart = "sleep 10s";
    };
  } else {};
}
