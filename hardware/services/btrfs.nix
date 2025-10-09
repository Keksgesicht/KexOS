{ config, pkgs, pkgs-stable, ssd-mnt, hdd-mnt, hdd-name, nvm-mnt, nvm-name, ... }:

let
  pkgs-sta = pkgs-stable {};
  hn = config.networking.hostName;
  timerConfig = config.KexOS.service."dummy".timer;
in
{
  environment.systemPackages = with pkgs; [
    btrfs-progs
    pkgs-sta.compsize
    duperemove
  ];

  services.btrfs.autoScrub = {
    enable = true;
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/tasks/filesystems/btrfs.nix
    # the above says the timer is "Persistent".
    interval = "*-1/2-13 04:20:42";
    fileSystems =
      if (hn == "cookieclicker") then
        [ "${ssd-mnt}" "${hdd-mnt}" "${nvm-mnt}" ]
      else if (hn == "cookieflyer") then
        [ "${ssd-mnt}" "/mnt/hot_backup" ]
      else [ "/" ];
  };

  # wait for drives to be mounted
  systemd.timers = if (hn == "cookieclicker") then {
    "btrfs-scrub-mnt-${hdd-name}" = timerConfig;
    "btrfs-scrub-mnt-${nvm-name}" = timerConfig;
  } else {};
}
