{ lib, home-dir, hdd-mnt, ... }:

let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./systemd.nix
  ];

  options.KexOS = {
    packages = mkOption {
      type = types.attrsOf types.package;
      default = {};
    };
    paths = mkOption {
      type = with types; attrsOf (oneOf [ path str ]);
      default = {};
    };
    variables = mkOption {
      type = with types; attrsOf (oneOf [ bool int path str ]);
      default = {};
    };
  };

  config.KexOS = {
    paths = {
      nixCfgHomeLink = "${home-dir}/nixos-config";
      nixCfgDataDir = "${home-dir}/git/hdd/nix/config/KexOS";
    };
    variables = {
      data-dir = "${hdd-mnt}/homeBraunJan";
    };
  };
}
