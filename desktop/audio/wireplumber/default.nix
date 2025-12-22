{ config, lib, ... }:

let
  hn = config.networking.hostName;
in
{
  # https://pipewire.pages.freedesktop.org/wireplumber/daemon/configuration/migration.html
  services.pipewire.wireplumber = {
    #enable = true;
    extraConfig = {
      "51-device-rename-pci-analog" = {
        "monitor.alsa.rules" = [ {
          matches = [
            { "node.name" = "alsa_output.pci-0000_0a_00.3.analog-surround-40"; }
          ];
          actions = {
            update-props = {
              "node.description" = "Mainboard Speaker";
              "node.nick" = "Mainboard Speaker";
            };
          };
        } ];
      };
    } // (if (hn == "cookieclicker") then {
      "90-keep-playback-on-disconnect" = {
        "wireplumber.settings" = {
            "linking.pause-playback" = false;
        };
      };
    } else {});
    extraScripts = {};
  };
}
