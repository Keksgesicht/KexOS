{ ... }:

{
  system.autoUpgrade.runGarbageCollection = true;

  nix.gc = {
    automatic = false;
    options = "--delete-older-than 32d";
  };

  systemd.services."nix-gc".serviceConfig = {
    CPUSchedulingPolicy = "idle";
    IOSchedulingClass = "idle";
    IOSchedulingPriority = 7;
  };
}
