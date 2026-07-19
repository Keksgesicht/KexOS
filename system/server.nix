{ pkgs, ... }:

{
  systemd.services = {
    "bluetooth-disable" = {
      enable = true;
      wantedBy = [
        "basic.target"
      ];
      after  = [
        "bluetooth.target"
        "systemd-rfkill.service"
      ];
      script = "${pkgs.util-linux}/bin/rfkill block bluetooth";
    };
  };
}
