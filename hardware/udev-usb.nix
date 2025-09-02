pkgs: lib: name: vendor: product: op:

pkgs.writeTextDir "etc/udev/rules.d/99-${name}.rules" (
  lib.strings.concatStringsSep ", " [
    "ACTION==\"add\"" "SUBSYSTEM==\"usb\"" "ATTR{idVendor}==\"${vendor}\""
    "ATTR{idProduct}==\"${product}\"" "${op}"
  ]
)
