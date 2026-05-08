{ config, pkgs, ... }:

let
  hn = config.networking.hostName;
  rfkill = "${pkgs.util-linux}/bin/rfkill";
in
{
  # enable bluetooth
  hardware.bluetooth = {
    enable = true;
    # https://wiki.archlinux.org/title/bluetooth#Default_adapter_power_state
    powerOnBoot = false;
  };

  powerManagement.asyncResumeCommands = [ (''
    ${rfkill} block bluetooth
  '' + (if (hn == "cookieclicker") then ''
    ${rfkill} block wifi
  '' else "")) ];
}
