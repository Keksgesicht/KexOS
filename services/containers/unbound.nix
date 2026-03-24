{ self, config, pkgs, lib, cookie-pkg, cookie-dir, ssd-mnt, myDomain
, lan-subnet-v4, pod-subnet-v4, vpn-subnet-v4
, lan-subnet-v6, pod-subnet-v6, vpn-subnet-v6
, ... }:

let
  str = lib.strings;
  hn = config.networking.hostName;

  my-functions = (import "${self}/nix/my-functions.nix" lib);
in
with my-functions;

let
  bind-path = "${ssd-mnt}/appdata/unbound";
  pss = (sec: (import ./podman-systemd-service.nix lib sec));

  myDomainGen = (l: forEach l (eL: forEach eL.zone (eZ:
    if ((str.hasPrefix "pihole." eZ.name)
    && ! (str.hasPrefix "${hn}.internal." (str.removePrefix "pihole." eZ.name)))
    then ""
    else ''
      local-zone: "${eZ.name}" ${eZ.type}
      local-data: "${eZ.name} 30 IN A ${eL.ip4}"
      local-data: "${eZ.name} 30 IN AAAA ${eL.ip6}"
    ''
  )));
  myServer = (name: suf: prefix:
    let
      pfx     = if (prefix == "") then "" else "${prefix}.";
      type    = if (prefix == "") then "redirect" else "static";
      subnet4 = if (prefix == "") then vpn-subnet-v4 else lan-subnet-v4;
      subnet6 = if (prefix == "") then vpn-subnet-v6 else lan-subnet-v6;
    in
    { ip4 = "${subnet4}.${suf}"; ip6 = "${subnet6}:${suf}"; zone = [
      { name = "${pfx}${name}.internal.${myDomain}"; inherit type; }
    ]; }
  );
  myDomainText = myDomainGen [
    (myServer "cookieclicker" "1" "")
    (myServer "cookieclicker" "220" "nix-serve")
    (myServer "cookieclicker" "220" "pihole")
    (myServer "cookieflyer" "2" "")
    (myServer "cookieflyer" "25" "nix-serve")
    (myServer "cookieflyer" "25" "pihole")
    (myServer "cookiemailer" "3" "")
    (myServer "cookiepi" "4" "")
    (myServer "cookiepi" "222" "nix-serve")
    (myServer "cookiepi" "222" "pihole")
  ];
  myDomainConf = pkgs.writeText "${myDomain}.conf" (
    lib.strings.concatStringsSep "\n" (flatList myDomainText)
  );
in
{
  imports = [
    ../../system/containers/podman.nix
    ./container-image-updater
  ];

  boot.kernel.sysctl = {
    "net.core.rmem_max" = 4194304;
    "net.core.wmem_max" = 4194304;
  };

  container-image-updater."unbound" = {
    upstream.name = "alpinelinux/unbound";
    final.name = "alpinelinux-unbound";
  };

  systemd = {
    services."podman-unbound" = (pss 17) // {
      after = [ "systemd-tmpfiles-resetup.service" ];
      partOf = [ "NetworkManager.service" ];
      restartTriggers = [ myDomainConf ];
    };
    tmpfiles.rules = [
      "r  ${bind-path}/conf/${myDomain}.conf - - - - -"
      "C+ ${bind-path}/conf/${myDomain}.conf - 100 101 - ${myDomainConf}"
    ];
  };

  KexOS.service."update-root-dns-servers" = {
    service = {
      after = [ "podman-pihole.service" ];
      description = "Download root DNS server list";
      path = with pkgs; [ curl nix unixtools.xxd ];
      serviceConfig = {
        ReadWritePaths = cookie-dir;
        InaccessiblePaths = lib.mkForce [];
      };
      script = ''
        set -e
        set -o pipefail
        URL="https://www.internic.net/domain/named.cache"
        HASHFILE="${cookie-dir}/root-dns-server.hash"
        mkdir -p "$(dirname "$HASHFILE")"
        nix-prefetch-url "$URL" 2>/dev/null | tee "$HASHFILE"
      '';
    };
    timer = {
      description = "Download root DNS server list";
      timerConfig.OnCalendar = "monthly";
    };
  };

  virtualisation.oci-containers.containers = {
    "unbound" = {
      autoStart = true;
      dependsOn = [];
      image = "localhost/unbound:latest";
      # https://ryantm.github.io/nixpkgs/builders/images/dockertools/
      imageFile = pkgs.dockerTools.buildImage {
        name = "localhost/unbound";
        tag = "latest";
        fromImage = config.container-image-updater."unbound".imageFile;
        copyToRoot = pkgs.buildEnv {
          name = "unbound-image-root";
          paths = [
            (pkgs.callPackage ../../packages/containers/unbound.nix {
              inherit cookie-pkg;
            })
          ];
          pathsToLink = [ "/scripts" ];
        };
        config.Cmd = [ "/scripts/entrypoint.sh" ];
      };
      ports = [
        "2053:53/tcp"
        "2053:53/udp"
      ];
      environment = {
        TZ = config.time.timeZone;
      };
      volumes = [
        "${ssd-mnt}/appdata/unbound:/etc/unbound:Z"
      ];
      extraOptions = [
        "--network" "server"
        "--ip"  "${pod-subnet-v4}.53.2"
        "--ip6" "${pod-subnet-v6}:aaaa:2"
        "--dns" "0.0.0.0"
      ];
    };
  };
}
