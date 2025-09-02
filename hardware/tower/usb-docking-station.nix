{ pkgs, lib, ... }:

let
  udev-usb = (import ../udev-usb.nix pkgs lib);
in
{
  services.udev.packages = [
    # disable USB ethernet adapter
    (udev-usb "usb-docking-disable-ethernet" "0b95" "1790" ''
      ATTR{authorized}="0"
    '')
  ];
}
