{ self, config, pkgs, lib, cookie-pkg, ssd-mnt, myDomain
, lan-subnet-v4, pod-subnet-v4, vpn-subnet-v4
, lan-subnet-v6, pod-subnet-v6, vpn-subnet-v6
, ... }:

let
  cookie-dir = "/etc/unCookie";
  cc-dir = "${cookie-pkg}/containers";
  bind-path = "${ssd-mnt}/appdata/unbound";
  my-functions = (import "${self}/nix/my-functions.nix" lib);
in
with my-functions;
{
  imports = [
    ../../system/containers/podman.nix
    ./container-image-updater
  ];

  container-image-updater."unbound" = {
    upstream.name = "alpinelinux/unbound";
    final.name = "alpinelinux-unbound";
  };

  systemd = {
    services = {
      "podman-unbound" = (import ./podman-systemd-service.nix lib 17) // {
        partOf = [ "NetworkManager.service" ];
      };
      "update-root-dns-servers" = {
        description = "Download root DNS server list";
        path = [
          pkgs.curl
          pkgs.nix
          pkgs.unixtools.xxd
        ];
        script = ''
          set -e
          set -o pipefail

          HASHFILE="${cookie-dir}/root-dns-server.hash"
          mkdir -p $(dirname $HASHFILE)

          URL="https://www.internic.net/domain/named.cache"
          NIX_STORE_FILE=$(nix-prefetch-url --print-path $URL | tail -n 1)
          HASH=$(sha256sum $NIX_STORE_FILE | cut -f1 -d' ' | xxd -r -p | base64)
          echo "sha256-$HASH" | tee $HASHFILE
        '';
      };
    };
    timers = {
      "update-root-dns-servers" = {
        enable = true;
        description = "Download root DNS server list";
        timerConfig = {
          OnCalendar = "monthly";
          RandomizedDelaySec = "42min";
          Persistent = "true";
        };
        wantedBy = [ "timers.target" ];
      };
    };
  };

  virtualisation.oci-containers.containers = {
    "unbound" = {
      autoStart = true;
      dependsOn = [];

      # https://ryantm.github.io/nixpkgs/builders/images/dockertools/
      image = "localhost/unbound:latest";
      imageFile = pkgs.dockerTools.buildImage {
        name = "localhost/unbound";
        tag = "latest";

        fromImage = pkgs.dockerTools.pullImage (
          builtins.fromJSON (builtins.readFile "${cc-dir}/alpinelinux-unbound.json")
        );

        copyToRoot = pkgs.buildEnv {
          name = "image-root";
          paths = [
            (pkgs.callPackage ../../packages/containers/unbound.nix {
              inherit cookie-pkg;
            })
          ];
          pathsToLink = [
            "/scripts"
          ];
        };
        config = {
          Cmd = [ "/scripts/entrypoint.sh" ];
        };
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

  systemd.tmpfiles.rules =
  let
    myDomainGen = (l: forEach l (eL: forEach eL.zone (eZ:
      ''
        local-zone: "${eZ.name}" ${eZ.type}
        local-data: "${eZ.name} 30 IN A ${eL.ip4}"
        local-data: "${eZ.name} 30 IN AAAA ${eL.ip6}"
      ''
    )));
    myDomainText = myDomainGen [
      { ip4 = "${vpn-subnet-v4}.2"; ip6 = "${vpn-subnet-v6}:2"; zone = [
        { name = "cookieflyer.${myDomain}"; type = "redirect"; }
      ]; }
      { ip4 = "${lan-subnet-v4}.25"; ip6 = "${lan-subnet-v6}:25"; zone = [
        { name = "nix-serve.cookieflyer.${myDomain}"; type = "static"; }
      ]; }
      { ip4 = "${vpn-subnet-v4}.1"; ip6 = "${vpn-subnet-v6}:1"; zone = [
        { name = "cookieclicker.${myDomain}"; type = "redirect"; }
      ]; }
      { ip4 = "${lan-subnet-v4}.220"; ip6 = "${lan-subnet-v6}:220"; zone = [
        { name = "nix-serve.cookieclicker.${myDomain}"; type = "static"; }
      ]; }
      { ip4 = "${vpn-subnet-v4}.3"; ip6 = "${vpn-subnet-v6}:3"; zone = [
        { name = "cookiemailer.${myDomain}"; type = "redirect"; }
      ]; }
    ];
    myDomainConf = pkgs.writeText "${myDomain}.conf" (
      lib.strings.concatStringsSep "\n" (flatList myDomainText)
    );
  in
  [
    "r  ${bind-path}/conf/${myDomain}.conf - - - - -"
    "C+ ${bind-path}/conf/${myDomain}.conf - 100 101 - ${myDomainConf}"
  ];

  boot.kernel.sysctl = {
    "net.core.rmem_max" = 4194304;
    "net.core.wmem_max" = 4194304;
  };
}
