{ system, ... }:

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

  systemd = {
    # running out of space when building larger projects
    # e.g. chromium for robotnix
    # run `nix build` with `--keep-failed` and do this:
    #   $AUTH mkdir -p /var/tmp/nix-daemon
    #   $AUTH rsync -avHAX --remove-source-files /tmp/nix-daemon/ /var/tmp/nix-daemon/
    #   $AUTH mount --bind /var/tmp/nix-daemon /tmp/nix-daem
    services."nix-daemon".environment.TMPDIR = "/tmp/nix-daemon";
    tmpfiles.rules = [ "q /tmp/nix-daemon 1777 root root 10d" ];
  };
}
