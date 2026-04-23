{ self, config, pkgs, lib, myDomain, ssd-mnt, ... }:

let
  hn = config.networking.hostName;
  pss = (sec: import ./podman-systemd-service.nix lib sec);

  subdomain-base = "wildcard,*.${hn}.internal";
  bind-path = "${ssd-mnt}/appdata/swag";
  swag-cfg = (pkgs.callPackage "${self}/packages/containers/swag-cfg.nix" {});

  base-update-srv = config.KexOS.service."server-and-config-update@";
  inherit (base-update-srv.service.serviceConfig) InaccessiblePaths;

  my-functions = (import "${self}/nix/my-functions.nix" lib);
in
with my-functions;
{
  imports = [
    ../../system/containers/podman.nix
    ../system/server-and-config-update.nix
    ./container-image-updater
  ];

  container-image-updater."proxy" = {
    upstream.name = "linuxserver/swag";
    final.name = "linuxserver-swag";
  };

  systemd.services."podman-proxy" = (pss 25) // {
    after = [ "systemd-tmpfiles-resetup.service" ];
    restartTriggers = [ swag-cfg ];
  };

  KexOS.service."server-and-config-update@SwagCertbot" = {
    service = {
      overrideStrategy = "asDropin";
      path = [ pkgs.podman ];
      description = "Renew SSL/TLS Certificate";
      serviceConfig = {
        BindReadOnlyPaths = "/etc/containers";
        ReadWritePaths = "/var/lib/containers/storage";
        InaccessiblePaths = lib.mkForce InaccessiblePaths.content;
      };
    };
    timer = {
      overrideStrategy = "asDropin";
      after = [ "podman-proxy.service" ];
      timerConfig.OnCalendar = "Wed *-*-* 20:20:00";
    };
  };

  virtualisation.oci-containers.containers = {
    "proxy" = {
      autoStart = true;
      dependsOn = [ "pihole" ];
      image     = config.container-image-updater."proxy".imageName;
      imageFile = config.container-image-updater."proxy".imageFile;
      environment = {
        TZ = config.time.timeZone;
        URL = myDomain;
        EMAIL = "certbot@${myDomain}";
        SUBDOMAINS =
          if (hn == "cookieflyer") then
            "${subdomain-base},cloud,links,tandoor.tb"
          else subdomain-base;
        ONLY_SUBDOMAINS = "true";
        VALIDATION = "dns";
        DNSPLUGIN = "hetzner-cloud";
        # seconds to wait for DNS record propagation
        PROPAGATION = "42";
        STAGING = "false";
        PUID = "99";
        PGID = "200";
      };
      volumes = [
        "${bind-path}:/config"
      ];
      extraOptions = [
        "--network" "host"
        "--dns" "172.23.53.2"
        "--dns" "fd00:172:23::aaaa:2"
        "--cap-add" "NET_ADMIN"
        "--cap-add" "NET_RAW"
      ];
    };
  };

  systemd.tmpfiles.rules = (forEach (listFilesRec swag-cfg) (e:
    let
      eFile = lib.removePrefix "${swag-cfg}" e;
    in
    "r ${bind-path}${eFile} - - - - -"
  )) ++ [
    "C+ ${bind-path}/nginx - 99 200 - ${swag-cfg}/nginx"
  ];
}
