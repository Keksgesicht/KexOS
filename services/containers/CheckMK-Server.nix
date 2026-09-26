{ config, lib, username, hdd-mnt, ... }:

{
  imports = [
    ../../system/containers/podman.nix
    ./container-image-updater
  ];

  container-image-updater."checkmk" = {
    upstream.name = "checkmk/check-mk-community";
  };

  systemd.services."podman-monitoring" = (import ./podman-systemd-service.nix lib 23);

  virtualisation.oci-containers.containers = {
    "monitoring" = {
      autoStart = true;
      image     = config.container-image-updater."checkmk".imageName;
      imageFile = config.container-image-updater."checkmk".imageFile;
      environment = {
        TZ = config.time.timeZone;
      };
      volumes = [
        "/etc/localtime:/etc/localtime:ro"
        "/tmp/check_mk/sites:/opt/omd/sites/cmk/tmp"
        "${hdd-mnt}/appdata2/check_mk/monitoring:/omd/sites"
      ];
      extraOptions = [
        "--network" "host"
        "--cap-add" "NET_RAW"
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "d  /tmp/check_mk        0750 - - - -"
    "d  /tmp/check_mk/sites  0755 ${username} ${username} - -"
  ];
}
