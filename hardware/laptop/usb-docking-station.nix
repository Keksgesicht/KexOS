{ pkgs, lib, ... }:

let
  udev-usb = (import ../udev-usb.nix pkgs lib);
  ethernet-delay-script = pkgs.writeShellScriptBin "ethernet-delay-script" ''
    sleep 3s
    echo "on" > /sys/bus/usb/devices/"$1"/power/control
  '';
in
{
  services.udev.packages = [
    # keyboard wakeup from suspend
    (udev-usb "usb-docking-keyboard-wakeup" "1017" "a002" ''
      ATTR{power/wakeup}="enabled"
    '')
    # enable ethernet adapter while charging
    (udev-usb "usb-docking-ethernet-while-charging" "0b95" "1790" ''
      RUN+="${ethernet-delay-script}/bin/ethernet-delay-script %k"
    '')
  ];
}
