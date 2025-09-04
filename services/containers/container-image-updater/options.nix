{ config, pkgs, lib, system, cookie-pkg, holidayMode, ... }:

let
  inherit (lib) types;

  cc-dir = "${cookie-pkg}/containers";

  ciuOpts = { name, config, ... }: {
    options = {
      arch = lib.mkOption {
        type = types.str;
        default = if (system ==  "x86_64-linux") then "amd64"
             else if (system == "aarch64-linux") then "arm64"
             else "amd64";
      };
      upstream.host = lib.mkOption {
        type = types.str;
        default = "docker.io";
      };
      upstream.name = lib.mkOption {
        type = types.str;
        default = "nixos/nix";
      };
      upstream.tag = lib.mkOption {
        type = types.str;
        default = "latest";
      };
      final.name = lib.mkOption {
        type = types.str;
        default = name;
      };
      final.tag = lib.mkOption {
        type = types.str;
        default = config.upstream.tag;
      };

      imageName = lib.mkOption {
        description = "Docker image name";
        internal = true;
        readOnly = true;
        type = types.str;
      };
      imageFile = lib.mkOption {
        description = "Docker pull config for Nix";
        internal = true;
        readOnly = true;
        type = types.nullOr types.package;
      };
    };

    config.imageName = "localhost/${config.final.name}:${config.final.tag}";
    config.imageFile = (
      let
        jsonFile = "${cc-dir}/${config.arch}/${config.final.name}.json";
      in
      if (builtins.pathExists jsonFile) then (pkgs.dockerTools.pullImage (
        builtins.fromJSON (builtins.readFile jsonFile)
      )) else null # fail container start and wait for updater service
    );
  };


  sd-name = (name: "container-image-updater@" + name);

  mkCIUservice = (config:
    {
      overrideStrategy = "asDropin";
      path = with pkgs; [ bash jq nix-prefetch-docker skopeo ];
      environment = {
        IMAGE_UPSTREAM_HOST = config.upstream.host;
        IMAGE_UPSTREAM_NAME = config.upstream.name;
        IMAGE_UPSTREAM_TAG  = config.upstream.tag;
        IMAGE_FINAL_NAME = "localhost/" + config.final.name;
        IMAGE_FINAL_TAG  = config.final.tag;
        IMAGE_ARCH       = config.arch;
      };
    }
  );
  mkCIUtimer = {
    enable = !holidayMode;
    overrideStrategy = "asDropin";
    wantedBy = [ "timers.target" ];
  };
in
with lib.attrsets;
{
  options.container-image-updater = lib.mkOption {
    default = {};
    type = types.attrsOf (types.submodule ciuOpts);
  };

  config.systemd = {
    services = (mapAttrs' (name: value: nameValuePair
      (sd-name name) (mkCIUservice value)
    ) config.container-image-updater);

    timers = (mapAttrs' (name: value: nameValuePair
      (sd-name name) (mkCIUtimer)
    ) config.container-image-updater);
  };
}
