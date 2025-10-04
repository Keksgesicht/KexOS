{ config, pkgs, lib, ... }:

let
  inherit (lib) types;
  inherit (lib) mkOption;

  udev-usb =  { name, config, ... }: {
    options = {
      vendor = mkOption {
        type = types.str;
        default = "0000";
      };
      product = mkOption {
        type = types.str;
        default = "0000";
      };
      cmd = mkOption {
        type = types.str;
        default = "echo \"dummy udev rule for USB device"
          + " ${config.vendor}:${config.product}\"";
      };
    };
  };

  subsys = "ACTION==\"add\" SUBSYSTEM==\"usb\"";
  aV = "ATTR{idVendor}";
  aP = "ATTR{idProduct}";
in
{
  options.services.udev.usbRule = mkOption {
    default = {};
    type = with types; attrsOf (submodule udev-usb);
  };

  config.services.udev.packages = lib.attrsets.mapAttrsToList (name: value:
    pkgs.writeTextDir "etc/udev/rules.d/${name}.rules" ''
       ${subsys} ${aV}=="${value.vendor}" ${aP}=="${value.product}" ${value.cmd}
    ''
  ) config.services.udev.usbRule;
}
