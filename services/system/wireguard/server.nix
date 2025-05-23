{ config, pkgs, lib, secrets-pkg, secrets-dir, username
, myDomain, vpn-subnet-v4, vpn-subnet-v6, ifLan, ... }:

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
  wg-client-handy = wg-client "handy" "handy-${hn}" "handy" "101" "10:1";

  # laptop
  wg-client-laptop = wg-client "cookiethinker" "" "" "102" "10:2";

  # rpi
  wg-rpi = wg-client "rpi" "" "" "103" "10:3";
  wg-rpi-click = wg-rpi // (cli-end "ub" "22263");

  # server
  wg-srv = (name: suf: wg-client name "" "" suf suf);
  wg-click = wg-srv "cookieclicker" "1";
  wg-mail = (wg-srv "cookiemailer" "3") // (cli-end "ma" "22301");
  wg-fly = wg-srv "cookieflyer" "2";

  hncc = hn != "cookieclicker";
  wg-fly-click = wg-fly // (cli-end "pi" "22243");

  # self
  wg-server = (suf: iface: listenPort: extPeers:
    let
      ipv4 = "${vpn-subnet-v4}.${suf}/24";
      ipv6 = "${vpn-subnet-v6}:${suf}/64";
    in
    {
      "wg-server" = {
        mtu = 1280;
        ips = [ ipv4 ipv6 ];
        privateKeyFile = "${wg-path-keys}/private";
        postSetup = (wg-nat ipv4 ipv6 iface "-A");
        postShutdown = (wg-nat ipv4 ipv6 iface "-D");
        inherit listenPort;
        peers = []
          ++ (lib.optionals (hn != "cookiemailer") [ wg-mail wg-client-handy ])
          ++ (lib.optionals (hncc) [ wg-click ])
          ++ (lib.optionals (hncc && hn != "cookieflyer" ) [ wg-fly ])
          ++ (lib.optionals (hncc && hn != "cookiepi" ) [ wg-rpi ])
          ++ [ wg-client-laptop ]
          ++ extPeers;
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
      wg-server "1" ifLan 22223 [ wg-fly-click wg-rpi-click ]
    else if (hn == "cookieflyer")  then (wg-server "2" "${ifLan}" 22243 [])
    else if (hn == "cookiemailer") then (wg-server "3" "invalid"  22301 [])
    else {};

  systemd.services =
  let
    # VPN should wait for finished DNS setup
    vpn-dns-delay = {
      after = [ "podman-pihole.service" ];
      preStart = "sleep 10s";
    };
    vpn-ping = (suf: ''
      ${pkgs.iputils}/bin/ping -c1 -W1 ${vpn-subnet-v4}.${suf} >/dev/null || true
    '');
    wg-refresh = (name: "wireguard-${wg-name}-peer-${name}-refresh");

    listRefresh = (pl: builtins.listToAttrs (map (e: {
      name = "${wg-refresh e}";
      value = vpn-dns-delay;
    }) pl ));
    listCheck = (pl: al: {
      "vpn-check-connectivity" = {
        wantedBy = [ "default.target" ];
        after = lib.lists.forEach pl (e: "${wg-refresh e}.service");
        script = ''
          while true; do
        '' + lib.strings.concatStrings (lib.lists.forEach al (e: vpn-ping e)) + ''
            sleep 60s
          done
        '';
      };
    });
  in
  if (hn == "cookieclicker") then
     (listRefresh [ "cookieflyer" "cookiemailer" "rpi" ])
    // (listCheck [ "cookieflyer" "cookiemailer" "rpi" ] [ "2" "3" "103" ])
  else if (hn == "cookieflyer") then
    (listCheck [ "cookiemailer" ] [ "3" ])
  else {};
}
