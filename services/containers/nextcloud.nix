{ config, pkgs, lib, secrets-dir, ssd-mnt, hdd-mnt, hdd-name, ... }:

let
  pss = (sec: import ./podman-systemd-service.nix lib sec);
  serviceExtraConfig = {
    after    = [ "mnt-${hdd-name}.mount" ];
    requires = [ "mnt-${hdd-name}.mount" ];
    unitConfig.WantsMountsFor = [
      "${nextcloud-hdd}/files_external/git-ssd"
      "${nextcloud-hdd}/files_external/homeBraunJan"
      "${nextcloud-hdd}/files_external/homeGaming"
    ];
  };

  auto-restart-script = ''
    DATE_PREFIX="$(date '+%d/%b/%Y:%H')"
    restart-nextcloud() {
      echo "Nextcloud Uptime Check: $1"
      echo "RESTARTING ALL NEXTCLOUD SERVICES"
      systemctl --no-block restart \
        podman-nextcloud.service \
        podman-nextcloud-db.service \
        podman-nextcloud-redis.service
    }
    NUM_SRV_ERR=$(cat "${nextcloud-ssd}/web/log/nginx/access.log" | \
      awk -v prefix="[$DATE_PREFIX" -F'|' 'index($0, prefix) == 1 {print $2}' | \
      awk '{print $1}' | grep -E '^504$' | wc -l)
    if [ 0 -lt "$NUM_SRV_ERR" ]; then
      restart-nextcloud "Internal Server Error"
    fi
    NUM_SRV_ERR=$(cat "${ssd-mnt}/appdata/swag/log/nginx/access-cloud.log" | \
      awk -v prefix="[$DATE_PREFIX" -F'|' 'index($0, prefix) == 1 {print $3}' | \
      awk '{print $1}' | grep -E '^502$' | wc -l)
    if [ 0 -lt "$NUM_SRV_ERR" ]; then
      restart-nextcloud "Gateway Error"
    fi
    exit 0
  '';

  nextcloud-ssd = "${ssd-mnt}/appdata/nextcloud";
  nextcloud-hdd = "${hdd-mnt}/appdata2/nextcloud";

  hot-path = "/mnt/hot_backup/data/cookieclicker";
  hot-opts = {
    fsType = "none";
    depends = [ hdd-mnt hot-path ];
    options = [
      "bind" "nofail" "x-gvfs-hide"
      "x-systemd.device-bound=yes"
      "x-systemd.requires-mounts-for=/mnt/hot_backup"
    ];
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
    "nextcloud-restart-on-error" = {
      path = with pkgs; [ coreutils gawk ];
      script = auto-restart-script;
      startAt = "*-*-* *:59:00";
      serviceConfig.Type = "oneshot";
    };
  };

  virtualisation.oci-containers.containers = {
    "nextcloud" = {
      autoStart = true;
      dependsOn = [
        "nextcloud-db"
        "nextcloud-redis"
      ];
      image     = config.container-image-updater."nextcloud".imageName;
      imageFile = config.container-image-updater."nextcloud".imageFile;
      environment = {
        TZ = config.time.timeZone;
        #PHP_MEMORY_LIMIT = "512M";
      };
      volumes = [
        "${nextcloud-ssd}/web:/config"
        "${nextcloud-hdd}/web:/data"
        "${nextcloud-hdd}/files_external:/files_external:ro"
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
        "${nextcloud-ssd}/db:/var/lib/mysql:Z"
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
        "${nextcloud-ssd}/redis/cfg:/etc/redis"
        "${nextcloud-ssd}/redis/data:/data"
      ];
      extraOptions = [
        "--network" "server"
        "--ip" "172.23.82.2"
        "--ip6" "fd00:172:23::443:2:2"
      ];
      cmd = [ "redis-server" "/etc/redis/redis.conf" ];
    };
  };

  fileSystems = {
    "${nextcloud-hdd}/files_external/git-ssd" = hot-opts // {
      device = "${hot-path}/home/keks/git";
    };
    "${nextcloud-hdd}/files_external/homeBraunJan" = hot-opts // {
      device = "${hot-path}/homeBraunJan";
    };
    "${nextcloud-hdd}/files_external/homeGaming" = hot-opts // {
      device = "${hot-path}/homeGaming";
    };
  };
}
