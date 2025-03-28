{ self, config, pkgs, lib, cookie-pkg, ssd-mnt
, lan-subnet-v4, lan-ip-suf, vpn-subnet-v4, vpn-ip-suf
, ... }:

let
  cc-dir = "${cookie-pkg}/containers";
  cfgNetName = config.networking.hostName;

  local-ips = [
    "${lan-subnet-v4}.${lan-ip-suf}"
    "${vpn-subnet-v4}.${vpn-ip-suf}"
  ];
  local-ports = [
    "53:53/tcp"
    "53:53/udp"
  ];

  my-functions = (import "${self}/nix/my-functions.nix" lib);
in
with my-functions;
{
  imports = [
    ../../system/containers/podman.nix
    ./container-image-updater
  ];

  container-image-updater."pihole" = {
    upstream.name = "pihole/pihole";
  };

  systemd.services."podman-pihole" = (import ./podman-systemd-service.nix lib 27);

  virtualisation.oci-containers.containers = {
    "pihole" = {
      autoStart = true;
      dependsOn = [ "unbound" ];

      image = "localhost/pihole:latest";
      imageFile = pkgs.dockerTools.pullImage (
        builtins.fromJSON (builtins.readFile "${cc-dir}/pihole.json")
      );

      ports = flatList (forEach local-ips (li: forEach local-ports (lp:
        "${li}:${lp}"
      )));
      environment = {
        TZ = config.time.timeZone;
        IPv6 = "True";
        ServerIP = "172.23.53.1";
        INTERFACE = "eth0";
        WEBUIBOXEDLAYOUT = "boxed";
      };
      volumes = [
        "${ssd-mnt}/appdata/pihole/cron.d/pihole:/etc/cron.d/pihole:z"
        "${ssd-mnt}/appdata/pihole/dnsmasq.d:/etc/dnsmasq.d:Z"
        "${ssd-mnt}/appdata/pihole/pihole:/etc/pihole:Z"
        #"/tmp/containers/pihole:/var/log"
      ];
      hostname = cfgNetName;
      extraOptions = [
        "--network" "server"
        "--ip" "172.23.53.1"
        "--ip6" "fd00:172:23::aaaa:1"
        "--dns" "172.23.53.2"
        "--dns" "fd00:172:23::aaaa:2"
        "--cap-add" "CAP_CHOWN"
      ];
    };
  };
}
