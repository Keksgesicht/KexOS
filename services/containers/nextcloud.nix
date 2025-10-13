{ config, pkgs, lib, secrets-dir, ssd-mnt, hdd-mnt, hdd-name, ... }:

let
  pss = (sec: import ./podman-systemd-service.nix lib sec);
  serviceExtraConfig = {
    after    = [ "mnt-${hdd-name}.mount" ];
    requires = [ "mnt-${hdd-name}.mount" ];
  };
in
{
  imports = [
    ../../system/containers/podman.nix
    ./container-image-updater
  ];

  container-image-updater = {
    "nextcloud" = {
      upstream.host = "lscr.io";
      upstream.name = "linuxserver/nextcloud";
      final.name = "linuxserver-nextcloud";
      final.tag = "stable";
    };
    "nextcloud-db" = {
      upstream.name = "mariadb";
      upstream.tag = "lts";
      final.name = "nextcloud-db";
    };
    "nextcloud-redis" = {
      upstream.name = "redis";
      final.name = "nextcloud-redis";
    };
  };

  systemd.services = {
    "podman-nextcloud" = (pss 23) // serviceExtraConfig;
    "podman-nextcloud-db" = (pss 27);
    "podman-nextcloud-redis" = (pss 27);
  };

  virtualisation.oci-containers.containers = {
    "nextcloud" = {
      autoStart = true;
      dependsOn = [
        "nextcloud-db"
        "nextcloud-redis"
      ];
      image = "localhost/nextcloud:stable";
      imageFile = pkgs.dockerTools.buildImage {
        name = "localhost/nextcloud";
        tag = "stable";
        fromImage = config.container-image-updater."nextcloud".imageFile;
        copyToRoot = pkgs.buildEnv {
          name = "nextcloud-image-root";
          paths = [ pkgs.ocrmypdf ] ++ pkgs.ocrmypdf.propagatedBuildInputs;
        };
        config = {
          Env = [ "LD_PRELOAD=" ];
          Cmd = [ "/init" ];
        };
      };
      environment = {
        TZ = config.time.timeZone;
        #PHP_MEMORY_LIMIT = "512M";
      };
      volumes = [
        "${ssd-mnt}/appdata/nextcloud:/config"
        "${hdd-mnt}/appdata2/nextcloud:/data"
        "${pkgs.ocrmypdf}/bin/ocrmypdf:/usr/local/bin/ocrmypdf:ro"
      ];
      extraOptions = [
        "--network" "server"
        "--ip" "172.23.80.2"
        "--ip6" "fd00:172:23::443:2"
        "--dns" "172.23.53.2"
        "--dns" "fd00:172:23::aaaa:2"
      ];
    };
    "nextcloud-db" = {
      autoStart = true;
      dependsOn = [];
      image     = config.container-image-updater."nextcloud-db".imageName;
      imageFile = config.container-image-updater."nextcloud-db".imageFile;
      cmd = [
        "--transaction-isolation=READ-COMMITTED"
        "--binlog-format=ROW"
      ];
      environment = {
        TZ = config.time.timeZone;
        MYSQL_DATABASE = "nextcloud";
        MYSQL_USER = "nextcloud";
        MARIADB_AUTO_UPGRADE = "1";
        MARIADB_INITDB_SKIP_TZINFO = "1";
      };
      environmentFiles = [
        "${secrets-dir}/keys/containers/nextcloud/MYSQL"
        "${secrets-dir}/keys/containers/nextcloud/MYSQL_ROOT"
      ];
      volumes = [
        "${ssd-mnt}/appdata/database/nextcloud:/var/lib/mysql:Z"
      ];
      extraOptions = [
        "--network" "server"
        "--ip" "172.23.82.1"
        "--ip6" "fd00:172:23::443:2:1"
      ];
    };
    "nextcloud-redis" = {
      autoStart = true;
      dependsOn = [];
      image     = config.container-image-updater."nextcloud-redis".imageName;
      imageFile = config.container-image-updater."nextcloud-redis".imageFile;
      environment = {
        TZ = config.time.timeZone;
      };
      environmentFiles = [
        "${secrets-dir}/keys/containers/nextcloud/REDIS"
      ];
      volumes = [
        "${ssd-mnt}/appdata/redis/nextcloud/cfg:/etc/redis"
        "${ssd-mnt}/appdata/redis/nextcloud/data:/data"
      ];
      extraOptions = [
        "--network" "server"
        "--ip" "172.23.82.2"
        "--ip6" "fd00:172:23::443:2:2"
      ];
      cmd = [ "redis-server" "/etc/redis/redis.conf" ];
    };
  };
}
