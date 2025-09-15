{ lib, ssd-mnt, ... }:

# https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi
let
  serviceConfig = {
    Nice = 13;
    OOMScoreAdjust = 123;
    CPUAccounting = true;
    CPUQuota = "80%";
  };
in
{
  imports = [
    ./sd-image-btrfs.nix
  ];

  # Older RPis have not a lot of memory.
  # Thus, disabling tmp in RAM is a good option.
  boot.tmp.useTmpfs = lib.mkForce false;

  # no smart capable disk avaiable
  services.smartd.enable = lib.mkForce false;

  swapDevices = [ {
    device = "${ssd-mnt}/swapfile";
    randomEncryption.enable = true;
    options = [ "nofail" ];
    size = 4096;
  } ];

  # reduce the load on the sd-card
  system.autoUpgrade = {
    # run updates only on the first tuesday of the month
    dates = lib.mkForce "Tue *-*-01..07 02:10";
    randomizedDelaySec = lib.mkForce "64min";
  };

  systemd.services = {
    # try not freezing RPi on rebuilds
    "nix-daemon" = { inherit serviceConfig; };
    "nixos-upgrade" = { inherit serviceConfig; };

    # sshd might not listen to the needed addresses
    # also RPi has no RTC. startup of NTP might be useful.
    "NetworkManager-wait-online".enable = lib.mkForce true;
  };
}
