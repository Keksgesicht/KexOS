{ lib, home-dir, ... }:

let
  inherit (lib) types;
in
{
  options.KexOS = {
    packages = lib.mkOption {
      type = types.attrsOf types.package;
      default = {};
    };
    paths = lib.mkOption {
      type = with types; attrsOf (oneOf [ str path ]);
      default = {};
    };
  };

  config.KexOS.paths = {
    nixCfgHomeLink = "${home-dir}/nixos-config";
    nixCfgDataDir = "${home-dir}/git/hdd/nix/config/KexOS";
  };
}
