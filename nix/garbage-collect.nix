{ holidayMode, ... }:

let
  delay = "15min";
in
{
  nix.gc = {
    automatic = !holidayMode;
    persistent = true;
    dates = "*-*-3/6 01:23:45";
    randomizedDelaySec = delay;
    options = "--delete-older-than 23d";
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
