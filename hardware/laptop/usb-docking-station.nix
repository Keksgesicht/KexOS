{ pkgs, ... }:

let
  ethernet-delay-script = pkgs.writeShellScriptBin "ethernet-delay-script" ''
    sleep 3s
    echo "on" > /sys/bus/usb/devices/"$1"/power/control
  '';
in
{
  imports = [
    ../common/usb-docking-station.nix
  ];

  services.udev.usbRule = {
    # enable ethernet adapter while charging
    "99-usb-docking-ethernet-while-charging" = {
      vendor = "0b95";
      product = "1790";
      cmd = "RUN+=\"${ethernet-delay-script}/bin/ethernet-delay-script %k\"";
    };
  };
}
