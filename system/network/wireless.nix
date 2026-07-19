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

  passwordFile = "${secrets-dir}/keys/wireless/pass/${hn}";
  authWPA = {
    mode = "wpa2-sha1";
    wpaPasswordFile = passwordFile;
  };
  authSea = {
    saePasswords = [{ inherit passwordFile; }];
  };
  defCfg = (band: channel: auth: rad:
    (netWifi
      ({ settings.bridge = "br-home"; authentication = auth; })
      ({ inherit band; inherit channel; } // rad)
    )
  );
in
{
  # avoid conflicts with NetworkManager
  networking.wireless.enable = lib.mkForce false;

  services.hostapd =
         if (hn == "cookieclicker") then (defCfg "2g" 1 authSea {})
    else if (hn == "cookiepi")      then (defCfg "2g" 4 authWPA {
        wifi4 = { enable = true; capabilities = [ "HT20" "SHORT-GI-20" ]; };
        wifi5.enable = false;
        wifi6.enable = false;
        wifi7.enable = false;
      })
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
