{ config, lib, secrets-dir, hdd-mnt, hdd-name, ... }:

let
  pss = (sec: import ./podman-systemd-service.nix lib sec);
  sec-file = "${secrets-dir}/keys/containers/tandoor/ENV";
  bind-path = "${hdd-mnt}/appdata2/tandoor";
in
{
  imports = [
    ../../system/containers/podman.nix
    ./container-image-updater
  ];

  container-image-updater = {
    "tandoor-web" = {
      upstream.name = "vabene1111/recipes";
      final.name = "tandoor-web";
    };
    "tandoor-db" = {
      upstream.name = "postgres";
      upstream.tag = "15-alpine";
      final.name = "tandoor-db";
      final.tag = "latest";
    };
  };

  systemd = {
    services =
    let
      serviceExtraConfig = {
        after    = [ "mnt-${hdd-name}.mount" ];
        requires = [ "mnt-${hdd-name}.mount" ];
      };
    in
    {
      "podman-tandoor-web" = (pss 17) // serviceExtraConfig;
      "podman-tandoor-db" = (pss 23) // serviceExtraConfig;
    };
  };

  # https://docs.tandoor.dev/install/docker/
  # https://github.com/TandoorRecipes/recipes
  virtualisation.oci-containers.containers = {
    "tandoor-web" = {
      autoStart = true;
      dependsOn = [ "tandoor-db" ];
      image     = config.container-image-updater."tandoor-web".imageName;
      imageFile = config.container-image-updater."tandoor-web".imageFile;
      environment = {
        TZ = config.time.timeZone;
      };
      environmentFiles = [ sec-file ];
      volumes = [
        # Do not make this a bind mount
        # see https://docs.tandoor.dev/install/docker/#volumes-vs-bind-mounts
        "tandoor-staticfiles:/opt/recipes/staticfiles"
        "${bind-path}/mediafiles:/opt/recipes/mediafiles"
      ];
      extraOptions = [
        "--network" "server"
        "--ip" "172.23.219.1"
        "--ip6" "fd00:172:23::219:1"
      ];
    };
    "tandoor-db" = {
      autoStart = true;
      dependsOn = [];
      image     = config.container-image-updater."tandoor-db".imageName;
      imageFile = config.container-image-updater."tandoor-db".imageFile;
      environment = {
        TZ = config.time.timeZone;
      };
      environmentFiles = [ sec-file ];
      volumes = [
        "${bind-path}/postgresql:/var/lib/postgresql/data"
      ];
      extraOptions = [
        "--network" "server"
        "--ip" "172.23.219.3"
        "--ip6" "fd00:172:23::219:3"
      ];
    };
  };
}
