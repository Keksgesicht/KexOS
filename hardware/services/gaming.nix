{ pkgs, lib, username, ... }:

{
  powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";

  users.users."${username}".packages = [
    pkgs.piper
  ];

  # configuring gaming mice
  services.ratbagd = {
    enable = true;
  };

  # Keyboard
  # https://github.com/anyc/skiller-ctl
}
