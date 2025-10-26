{ config, pkgs, lib, username, home-dir, ... }:

let
  inherit (lib) mkOption types;

  lsp-path-local = "/usr/local/lsp";
  lsp-path-nix = pkgs.symlinkJoin {
    name = "lsp-pkgs-joined";
    paths = config.KexOS.lsp-wrapper.lsp-pkgs;
  };

  pkgWrapOpts = types.submodule ({ config, ... }: {
    options = {
      package = lib.mkOption {
        type = types.package;
      };
      binName = lib.mkOption {
        type = types.str;
        default = config.package.name;
      };
    };
  });

  ide-wrapper = (n: p: pkgs.writeShellScriptBin "${n}" ''
    export PATH=${lsp-path-local}/bin:$PATH
    export CPATH=${home-dir}/git/hdd/header
    exec ${p}/bin/${n} "$@"
  '');
  ide-lsp-wrapped = (n: p: pkgs.symlinkJoin {
    name = "${n}-with-language-server";
    paths = [ (ide-wrapper n p) p ];
  });
in
{
  options.KexOS.lsp-wrapper = {
    lsp-pkgs = mkOption {
      type = types.listOf types.package;
      default = [];
    };
    ide-pkgs = mkOption {
      type = types.listOf pkgWrapOpts;
      default = [];
    };
  };

  config.KexOS.lsp-wrapper = {
    lsp-pkgs = with pkgs; [
      # Bash
      bash-language-server shfmt
      # C/C++
      clang-tools
      # GO
      gopls go
      # Java
      jdt-language-server
      # JSON
      jq
      # LaTeX
      texlab
      # Markdown
      marksman
      # Nix
      nil
      # Python
      python3Packages.python-lsp-server ruff
      # XML
      lemminx libxml2
      # YAML
      yaml-language-server yamlfmt
    ];
    ide-pkgs = [];
  };

  config.users.users."${username}".packages = lib.lists.forEach (
    config.KexOS.lsp-wrapper.ide-pkgs
  ) (p: ide-lsp-wrapped p.binName p.package);

  config.systemd.tmpfiles.rules = [
    # dedicated path for lsp servers
    "L+ ${lsp-path-local} - - - - ${lsp-path-nix}"
  ];
}
