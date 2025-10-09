{ config, system, ... }:

let
  timerConfig = config.KexOS.service."dummy".timer;
in
{
  # set hardware architecture and os platform
  nixpkgs.hostPlatform = {
    inherit system;
  };

  nix = {
    # make system useable during (re)build
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;

    # https://nixos.wiki/wiki/Storage_optimization
    # removes duplicates by creating hardlinks for matching files
    # $AUTH nix-store --optimise
    optimise = {
      automatic = true;
      dates = [ "12:34" ];
    };
    #settings.auto-optimise-store = true;

    # enable flake commands
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  systemd.timers."nix-optimise" = timerConfig;
}
