{ config, pkgs, lib,  ... }:

let
  inherit (lib) mkOption types;
in
{
  options.powerManagement.asyncResumeCommands = mkOption {
    type = with types; listOf str;
    default = [];
  };

  config.powerManagement.resumeCommands = lib.mkAfter (''
      sleep 5s
      pids_background=()

    '' + lib.strings.concatLines (lib.lists.forEach
      config.powerManagement.asyncResumeCommands (e:
        let
          resume-exec = pkgs.writeShellScriptBin "resume-command" e;
        in
        ''
          ${resume-exec}/bin/resume-command &
          pids_background+=("$!")
        ''
      )
    ) + ''
      for pid_bg in "''${pids_background[@]}"; do
        wait "$pid_bg"
      done
    ''
  );
}
