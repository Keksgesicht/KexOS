{ config, pkgs, lib, secrets-dir, secrets-pkg, ifWlan, ... }:

let
  hn = config.networking.hostName;
  rf = builtins.readFile;

  netWifi = (authMeth: radCfg: {
    enable = true;
    radios."${ifWlan}" = {
      countryCode = "DE";
      networks."${ifWlan}" = {
        group = "root";
        ssid = rf "${secrets-pkg}/wireless/ssid/${hn}";
      } // authMeth;
    } // radCfg;
  });

  authSea = {
    authentication.saePasswords = [{
      passwordFile = "${secrets-dir}/keys/wireless/pass/${hn}";
    }];
  };
in
{
  services.hostapd =
    if (hn == "cookieclicker") then
      (netWifi
        (authSea // { settings.bridge = "br-home"; })
        ({ band = "2g"; channel = 4; })
      )
    else {};

  systemd.services."hostapd" = {
    #overrideStrategy = "asDropin";
    serviceConfig = {
      ExecStartPre = "${pkgs.util-linux.bin}/bin/rfkill unblock wlan";
      ExecStopPost = "${pkgs.util-linux.bin}/bin/rfkill block wlan";
      LogFilterPatterns = [
        "~handle_probe_req: send failed"
      ];
    };
    # Clear WantedBy list, so it will not autostart on certain systems
    wantedBy = if (hn == "cookieclicker") then lib.mkForce [] else [];
  };
}
