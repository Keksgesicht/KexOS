{ holidayMode, ... }:

let
  delay = "15min";
in
{
  nix.gc = {
    automatic = !holidayMode;
    persistent = true;
    dates = "Sat *-*-* 01:23:45";
    randomizedDelaySec = delay;
    options = "--delete-older-than 32d";
  };

  systemd.services."nix-gc".serviceConfig = {
    CPUSchedulingPolicy = "idle";
    IOSchedulingClass = "idle";
    IOSchedulingPriority = 7;
  };
  systemd.timers."nix-gc".timerConfig = {
    OnBootSec = delay;
  };
}
