{ self, specialArgs, config, pkgs, lib, ... }:

let
  inherit (lib) types;

  mapAL = lib.attrsets.mapAttrsToList;
  hn = config.networking.hostName;

  inherit (specialArgs) lan-subnet-v6;
  inherit (specialArgs) lan-ip-suf;
  inherit (specialArgs) ifLan;

  scriptOpts = { name, config, ... }: {
    options = {
      packages = lib.mkOption {
        type = types.listOf types.package;
        default = [];
      };
      variables = lib.mkOption {
        type = with types; attrsOf (oneOf [ (listOf str) str path ]);
        default = {};
        apply = lib.attrsets.mapAttrs (n: v:
          if lib.isList v then
            lib.strings.concatStringsSep ":" v
          else "${v}"
        );
      };
      input.path = lib.mkOption {
        type = with types; oneOf [ str path ];
        default = "${self}/files/linux-root/etc/NetworkManager/dispatcher.d";
      };
      input.file = lib.mkOption {
        type = with types; oneOf [ str path ];
        default = name;
      };
      output.script = lib.mkOption {
        type = types.package;
        internal = true;
        readOnly = true;
      };
    };

    config = {
      variables = {
        MY_PATH = "$PATH:" + (lib.strings.makeSearchPath "bin" config.packages);
        MY_IPV6_ULU = "${lan-subnet-v6}:${lan-ip-suf}/64";
        MY_IFLINK =
          if (hn == "cookieclicker") then "br-home"
          else ifLan;
        MY_IPV6_SUFFIX =
               if (hn == "cookieclicker") then "da:b44:${lan-ip-suf}:1"
          else if (hn == "cookieflyer")   then "da:c54:${lan-ip-suf}:2"
          else if (hn == "cookiepi")      then "da:b44:${lan-ip-suf}:4"
          else "dead:beef:0815:42";
      };
      output.script = pkgs.writers.writeBash name (
        (lib.strings.concatStrings (mapAL (name: value: ''
          ${name}="${value}"
          export ${name}
        '') config.variables)) + ''
          PATH="$MY_PATH"
          export PATH
        '' + (
          builtins.readFile "${config.input.path}/${config.input.file}"
        )
      );
    };
  };
in
{
  options.networking.networkmanager.dispatcherScript = lib.mkOption {
    type = types.attrsOf (types.submodule scriptOpts);
    default = {};
  };

  config.networking.networkmanager.dispatcherScripts = mapAL (name: value: {
    type = "basic";
    source = value.output.script;
  }) config.networking.networkmanager.dispatcherScript;
}
