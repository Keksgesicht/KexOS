{ ... }:

{
  imports = [
    ../common/udev-usb.nix
  ];

  services.udev.usbRule = {
    # disable USB ethernet adapter
    "99-usb-docking-disable-ethernet" = {
      vendor = "0b95";
      product = "1790";
      cmd = "ATTR{authorized}=\"0\"";
    };
  };
}
