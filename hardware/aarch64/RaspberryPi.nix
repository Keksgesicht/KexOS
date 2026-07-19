{ pkgs, lib, ssd-mnt, lan-subnet-v4, lan-ip-suf, ... }:

# https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi
let
  serviceConfig = {
    Nice = 13;
    OOMScoreAdjust = 123;
    #CPUAccounting = true;
    #CPUQuota = "80%";
    Slice = "system-nix\\x2ddaemon.slice";
  };
  sliceConfig = {
    MemorySwapMax =   "6G";
    MemoryMax     = "384M";
    MemoryHigh    = "384M";
    CPUWeight     =     95;
    IOWeight      =     75;
  };

  dns-cfg = pkgs.writeText "wg-refresh-resolv.conf" ''
    nameserver 172.23.53.1
    nameserver ${lan-subnet-v4}.${lan-ip-suf}
    nameserver 9.9.9.9
    options timeout:3
    options attempts:1
  '';
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

  # do not freeze system on updates or rebuilds
  KexOS.packages."rebuild" = lib.mkForce pkgs.hello;
  systemd.slices = {
    "system-nix\\x2ddaemon" = { inherit sliceConfig; };
  };
  swapDevices = [ {
    device = "${ssd-mnt}/swapfile";
    randomEncryption.enable = true;
    options = [ "nofail" ];
    size = 4096;
  } ];

  # build remotely and only copy closures to this system
  # TODO create service on cookieflyer for this
  system.autoUpgrade.enable = lib.mkForce false;

  # force non Lix version
  services.nix-serve.package = lib.mkForce pkgs.nix-serve;

  systemd.services = {
    # try not freezing RPi on any Nix commands
    "nix-daemon" = { inherit serviceConfig; };
    "nixos-upgrade" = { inherit serviceConfig; };

    # sshd might not listen to the needed addresses
    # also RPi has no RTC. startup of NTP might be useful.
    "NetworkManager-wait-online".enable = lib.mkForce true;

    # RPi has no RTC and might not be able to use DNS
    "systemd-timesyncd".serviceConfig = {
      # force the usage of DNS servers defined in the unit scope
      TemporaryFileSystem = "/var/run/nscd";
      BindReadOnlyPaths = "${dns-cfg}:/etc/resolv.conf";
    };
  };
}
