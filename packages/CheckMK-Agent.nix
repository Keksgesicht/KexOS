{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkOption types;
  inherit (lib.lists) forEach;

  cfg = config.services.checkmk-agent;

  checkmk-agent-pkg = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "check-mk-agent";
    version = "2.5.0";

    src = pkgs.fetchFromGitHub {
      owner = "Checkmk";
      repo = "checkmk";
      rev = version;
      hash = "sha256-zIQgjpNKdJO7ddmmZ/5NpBRjJlPrrS1p4snJ2OcW72c=";
    };

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      install -Dm755 agents/check_mk_agent.linux \
        $out/bin/check_mk_agent

      mkdir -p \
        $out/etc/check_mk \
        $out/lib/check_mk_agent/plugins \
        $out/lib/check_mk_agent/local \
        $out/var/lib/check_mk_agent
      '' + (lib.strings.concatStrings (forEach cfg.plugins (e: ''
        install -Dm755 agents/plugins/${e} \
          $out/lib/check_mk_agent/plugins/${e}
      ''))) + (lib.strings.concatStrings (forEach cfg.externalPlugins (e: ''
        mkdir ./plugin.dir
        tar -xf ${e} -C ./plugin.dir
        tar -xf ./plugin.dir/agents.tar \
          -C "$out/lib/check_mk_agent/"
        rm -fr ./plugin.dir
      ''))) + ''
      runHook postInstall
    '';

    meta = {
      description = "Checkmk Linux monitoring agent";
      homepage = "https://checkmk.com/";
      license = lib.licenses.gpl2Only;
      platforms = lib.platforms.linux;
      mainProgram = "check_mk_agent";
    };
  };
  checkmk-agent = pkgs.writeShellScriptBin "check_mk_agent" ''
    export MK_CONFDIR="${checkmk-agent-pkg}/etc/check_mk"
    export MK_LIBDIR="${checkmk-agent-pkg}/lib/check_mk_agent"
    export MK_VARDIR="${checkmk-agent-pkg}/var/lib/check_mk_agent"
    exec ${checkmk-agent-pkg}/bin/check_mk_agent "$@"
  '';
in
{
  options.services.checkmk-agent = {
    enable = mkEnableOption "Enable Checkmk monitoring agent";
    package = mkOption {
      type = types.package;
      default = checkmk-agent;
    };
    plugins = mkOption {
      type = types.listOf types.str;
      default = [];
    };
    externalPlugins = mkOption {
      type = types.listOf types.package;
      default = [];
    };
    openFirewall = lib.mkEnableOption "Allow remote access to CheckMK agent";
    port = mkOption {
      type = types.port;
      default = 6557;
      description = "TCP port on which the Checkmk agent listens.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.sockets.checkmk-agent = {
      description = "Checkmk Agent socket";
      wantedBy = [ "sockets.target" ];
      socketConfig = {
        ListenStream = cfg.port;
        Accept = true;
      };
    };

    systemd.services."checkmk-agent@" = {
      description = "Checkmk Agent";
      path = with pkgs; [
        coreutils ethtool gawk glibc.bin gnugrep gnused
        iproute2 procps python3 systemd util-linux
      ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${cfg.package}/bin/check_mk_agent";
        TimeoutStopSec = 10;

        StandardInput = "socket";
        StandardOutput = "socket";
        StandardError = "journal";

        User = "root";
        Group = "root";

        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = "read-only";
        ReadWritePaths = [
          "/var/lib/check_mk_agent"
        ];
      };
    };

    networking.firewall.allowedTCPPorts = lib.optionals (cfg.openFirewall) [
      cfg.port
    ];
  };
}
