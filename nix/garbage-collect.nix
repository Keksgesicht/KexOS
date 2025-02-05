{ holidayMode, ... }:

{
  nix.gc = {
    automatic = !holidayMode;
    persistent = true;
    dates = "*-*-3/6 01:23:45";
    randomizedDelaySec = "15min";
    options = "--delete-older-than 23d";
  };
}
