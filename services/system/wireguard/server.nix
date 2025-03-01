{ config, pkgs, lib, secrets-pkg, secrets-dir, username
, myDomain, vpn-subnet-v4, vpn-subnet-v6, ... }:

let
  wg-name = "wg-server";
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
      ${iptbl4} ${ad} FORWARD -i ${wg-name} -j ACCEPT
      ${iptbl4} -t nat ${ad} POSTROUTING -s ${ipv4} -o ${port} -j MASQUERADE
      ${iptbl6} ${ad} FORWARD -i ${wg-name} -j ACCEPT
      ${iptbl6} -t nat ${ad} POSTROUTING -s ${ipv6} -o ${port} -j MASQUERADE
      ${logger} -t wireguard "Tunnel WireGuard (${wg-name}) ${nat-log}"
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
      "${vpn-subnet-v4}.${suf4}/32"
      "${vpn-subnet-v6}:${suf6}/128"
    ];
  });
  cli-end = (n: p: {
    endpoint = "${n}.host.${myDomain}:${p}";
    dynamicEndpointRefreshSeconds = 1000;
  });

  # handy
  wg-client-handy = (host: wg-client "handy" "handy-${host}" "" "101" "10:1");

  # laptop
  wg-client-laptop = wg-client "cookiethinker" "" "" "102" "10:2";

  # rpi
  wg-clicker-pihole = (wg-client "rpi" "" "cookieclicker-rpi" "103" "10:3")
    // (cli-end "ub" "22263");
  wg-rpi = wg-client "rpi" "" "cookiepi-rpi" "103" "10:3";

  # cookiepi
  wg-clicker-pi = (wg-client "cookiepi" "" "cookiepi-cookieclicker" "2" "2")
   // (cli-end "pi" "22243");

  # cookieclicker
  wg-pi-clicker = (wg-client "cookieclicker" "" "cookiepi-cookieclicker" "1" "1");

  # self
  wg-server = (name: suf4: suf6: iface: listenPort: extPeers:
    let
      ipv4 = "${vpn-subnet-v4}.${suf4}/24";
      ipv6 = "${vpn-subnet-v6}:${suf6}/64";
    in
    {
      "wg-server" = {
        mtu = 1280;
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

  environment.shellAliases.wg = "${pkgs.wireguard-tools}/bin/wg";
  security.sudo.extraRules = [ {
    users = [ username ];
    commands = [ {
      options = [ "NOPASSWD" ];
      command = "${pkgs.wireguard-tools}/bin/wg show ${wg-name}";
    } ];
  } ];

  networking.wireguard.interfaces =
    if (hn == "cookieclicker") then
      wg-server "cookieclicker" "1" "1" "enp4s0" 22223 [
        wg-clicker-pi
        wg-clicker-pihole
      ]
    else if (hn == "cookiepi") then
      wg-server "cookiepi" "2" "2" "enp0s31f6" 22243 [
        wg-pi-clicker
        wg-rpi
      ]
    else {}
  ;

  systemd.services =
  let
    # VPN should wait for finished DNS setup
    vpn-dns-delay = {
      after = [ "podman-pihole.service" ];
      preStart = "sleep 10s";
    };
    vpn-ping = (suf: ''
      ${pkgs.iputils}/bin/ping -c3 -W1 ${vpn-subnet-v4}.${suf} >/dev/null || true
    '');
    wg-refresh = (name: "wireguard-${wg-name}-peer-${name}-refresh");
  in
  if (hn == "cookieclicker") then {
    "${wg-refresh "cookiepi"}" = vpn-dns-delay;
    "${wg-refresh "rpi"}" = vpn-dns-delay;
    "vpn-check-connectivity" = {
      after = [
        "${wg-refresh "cookiepi"}.service"
        "${wg-refresh "rpi"}.service"
      ];
      startAt = "*:0/5";
      script = (vpn-ping "2") + (vpn-ping "103");
    };
  } else {};
}
