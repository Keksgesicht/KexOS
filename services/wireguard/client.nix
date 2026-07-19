{ self, pkgs, lib, secrets-pkg, secrets-dir, username, myDomain
, lan-subnet-v4, vpn-subnet-v4, vpn-subnet-v6, ... }:

let
  wg-name = "laptop";

  wg-path-data = "${secrets-pkg}/wireguard";
  wg-path-keys = "${secrets-dir}/keys/wireguard";
  wg-pubkey = (name:
    lib.removeSuffix "\n" (builtins.readFile "${wg-path-data}/public/${name}")
  );
  ip-rt = (v: o: a: "ip -${v} route ${o} default via ${a} metric 50");
  wg-cmd = (name:
    "${pkgs.wireguard-tools}/bin/wg show wg-${name}"
  );

  sc-cmd-wg-cmd = (name: "${pkgs.wireguard-tools}/bin/wg set wg-${name} peer ");
  sc-cmd-prefix = (name: pKey: (sc-cmd-wg-cmd name) + "${wg-pubkey pKey}");
  sc-cmd-start = (name: pKey: suf4: suf6: ''
    ${sc-cmd-prefix name pKey} allowed-ips 0.0.0.0/0,::/0
    ${ip-rt "4" "add" "${vpn-subnet-v4}.${suf4}"}
    ${ip-rt "6" "add" "${vpn-subnet-v6}:${suf6}"}
  '');
  sc-cmd-stop = (name: pKey: suf4: suf6: ''
    ${ip-rt "4" "del" "${vpn-subnet-v4}.${suf4}"}
    ${ip-rt "6" "del" "${vpn-subnet-v6}:${suf6}"}
    ${sc-cmd-prefix name pKey} allowed-ips \
      ${vpn-subnet-v4}.${suf4}/32\,${vpn-subnet-v6}:${suf6}/128
  '');

  wg-srv = (e: "wireguard-wg-${wg-name}-peer-${e.name}-refresh");

  wg-cmd-peer = (e: ''
    ${e.name})
      case "$2" in
        up)
          ${pkgs.systemd}/bin/systemctl stop "${wg-srv e}.service"
          ${sc-cmd-start wg-name e.name e.suf4 e.suf6}
        ;;
        down)
          ${sc-cmd-stop wg-name e.name e.suf4 e.suf6}
          ${pkgs.systemd}/bin/systemctl start "${wg-srv e}.service"
        ;;
        refresh)
          ${pkgs.systemd}/bin/systemctl restart "${wg-srv e}.service"
        ;;
      esac
    ;;
  '');
  wg-cmd-script = pkgs.writeShellScriptBin "wg-tool" (''
    case "$1" in
  ''
  + lib.strings.concatStrings (lib.lists.forEach peerList (e:
    wg-cmd-peer e
  )) + ''
    list)
  ''+ lib.strings.concatStrings (lib.lists.forEach peerList (e:
    "echo ${e.name}; "
  )) + ''
      ;;
      up)
        ${pkgs.systemd}/bin/systemctl start "wireguard-wg-${wg-name}.service"
      ;;
      down)
        ${pkgs.systemd}/bin/systemctl stop "wireguard-wg-${wg-name}.service"
      ;;
      show)
        ${wg-cmd wg-name}
      ;;
      *)
        echo "Unknown wireguard peer!"
        exit 1
      ;;
    esac
  '');

  peerList = [ {
      name = "cookieclicker";
      suf4 = "1";  suf6 = "1";
      ep = "tw.host.${myDomain}:22223";
    } {
      name = "cookieflyer";
      suf4 = "2"; suf6 = "2";
      ep = "fy.host.${myDomain}:22243";
    } {
      name = "cookiemailer";
      suf4 = "3"; suf6 = "3";
      ep = "ma.host.${myDomain}:22301";
    } {
      name = "cookiepi";
      suf4 = "4"; suf6 = "4";
      ep = "pi.host.${myDomain}:22263";
  } ];

  sysd-restart = (e:
    "/run/current-system/systemd/bin/systemctl " +
    "--no-block restart \"wireguard-wg-${wg-name}-peer-${e.name}-refresh\""
  );

  my-functions = (import "${self}/nix/my-functions.nix" lib);

  wg-restart = with my-functions; concatStr (forEach peerList (e: ''
    ${sysd-restart e} || true
  ''));
in
with my-functions;
{
  imports = [
    "${self}/nix/KexOS/resume-commands.nix"
    "${self}/nix/secrets-pkg.nix"
  ];

  users.users."${username}".packages = [ wg-cmd-script ];
  environment.shellAliases.wg-tool = "sudo ${wg-cmd-script}/bin/wg-tool";
  security.sudo-rs.extraRules = [ {
    users = [ username ];
    commands = [ {
      options = [ "NOPASSWD" ];
      command = "${wg-cmd-script}/bin/wg-tool";
    } ];
  } ];

  networking.wireguard.interfaces =
  let
    wgPeers = (ep: pKey: suf4: suf6: {
      name = pKey;
      endpoint = ep;
      publicKey = (wg-pubkey pKey);
      presharedKeyFile = "${wg-path-keys}/shared/${pKey}";
      dynamicEndpointRefreshSeconds = 300;
      allowedIPs = [
        "${vpn-subnet-v4}.${suf4}/32"
        "${vpn-subnet-v6}:${suf6}/128"
      ];
    });
    wgDNScfg = pkgs.writeText "wg-laptop-resolv.conf" (''
      nameserver ${vpn-subnet-v4}.2
      nameserver ${vpn-subnet-v4}.103
      options timeout:2
      options attempts:2
    '');
  in
  {
    "wg-${wg-name}" = {
      privateKeyFile = "${wg-path-keys}/private";
      ips = [
        "${vpn-subnet-v4}.102/24"
        "${vpn-subnet-v6}:10:2/64"
      ];
      mtu = 1280;
      peers = forEach peerList (e: (wgPeers e.ep e.name e.suf4 e.suf6));
      postSetup = "cat ${wgDNScfg} | resolvconf -a wg-${wg-name} -m 0 -x";
      postShutdown = "resolvconf -d wg-${wg-name} -f";
    };
  };

  systemd.services =
  let
    vpn-dns-cfg = pkgs.writeText "wg-refresh-resolv.conf" ''
      nameserver ${lan-subnet-v4}.220
      nameserver ${lan-subnet-v4}.221
      nameserver 9.9.9.9
      options timeout:3
      options attempts:1
    '';
    vpn-srv-dns = {
      serviceConfig = {
        # force the usage of DNS servers defined in the unit scope
        TemporaryFileSystem = "/var/run/nscd";
        BindReadOnlyPaths = "${vpn-dns-cfg}:/etc/resolv.conf";
      };
    };
    vpn-ping = (suf: ''
      ${pkgs.iputils}/bin/ping -c1 -W1 ${vpn-subnet-v4}.${suf} >/dev/null || true
    '');
  in
  builtins.listToAttrs (map (e: {
    name = wg-srv e;
    value = vpn-srv-dns;
  }) peerList) // {
    "wireguard-wg-${wg-name}" = {
      path = [ pkgs.openresolv ];
      serviceConfig.PrivateTmp = true;
    };
    "vpn-check-connectivity" = {
      wantedBy = [ "default.target" ];
      after = forEach peerList (e: "${wg-srv e}.service");
      script = ''
        while true; do
      '' + concatStr (forEach peerList (e: vpn-ping e.suf4)) + ''
          sleep 60s
        done
      '';
    };
    "vpn-net-delay" = {
      # VPN should retry after WiFi connectivity
      after = [ "user@1000.service" ];
      wantedBy = [ "user@1000.service" ];
      preStart = "sleep 5s";
      script = wg-restart;
    };
  };

  powerManagement.asyncResumeCommands = [ wg-restart ];
}
