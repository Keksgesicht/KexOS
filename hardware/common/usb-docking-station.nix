{ ... }:

{
  imports = [
    ../common/udev-usb.nix
  ];

  services.udev.usbRule = {
    # keyboard wakeup from suspend
    "99-usb-docking-keyboard-wakeup" = {
      vendor = "1017";
      product = "a002";
      cmd = "ATTR{power/wakeup}=\"enabled\"";
    };
  };
}
