{ pkgs, ... }:

{
  imports = [
    ./directories.nix
    ./files.nix
  ];

  systemd.user = {
    services = {
      "prestart-tools" = {
        description = "Start tools early to speed up later usage";
        serviceConfig = {
          StandardOutput = null;
          StandardError = null;
        };
        path = with pkgs; [
          nix fastfetch
        ];
        script = ''
          fastfetch
          nix-shell -p bash
        '';
      };
    };
    timers = {
      "prestart-tools" = {
        timerConfig.OnStartupSec = "42sec";
        wantedBy = [ "timers.target" ];
      };
    };
  };
}
