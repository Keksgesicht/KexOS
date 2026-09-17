{ pkgs, lib, ... }:

let
  tpmAcpiInitrd = pkgs.runCommand "acpi-tpm2-override.cpio" {
    # dump ACPI table and decompile
    # > sudo acpidump -b -t DSDT
    # > iasl -d dsdt.dat
    # replace `LTFB = 0x1000` with `LTFB = 0x4000` to fill hole
    src = ../../files/dsdt-tpm-fix.dsl;
    nativeBuildInputs = with pkgs; [
      acpica-tools
      cpio
    ];
  } ''
    mkdir -p kernel/firmware/acpi
    iasl -p "$PWD/DSDT" -sa "$src" 2>/dev/null
    cp DSDT.aml kernel/firmware/acpi/dsdt.aml
    find kernel | cpio -H newc --create > "$out"
  '';
in
{
  # disable systemd unit to reduce boot time while testing
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = lib.mkForce false;

  boot = {
    # override ACPI tables
    initrd.prepend = lib.mkBefore [ "${tpmAcpiInitrd}" ];

    kernelParams = [
      # https://github.com/mrnossiom/dotfiles/blob/4114457a7070f0fe3b306520cf7ffb9cafc11d85/modules/nixos/asus-zenbook-ux3402za-sound.nix
      "acpi.debug_level=0x2"
      "acpi.debug_layer=0xFFFFFFFF"
      /*
      # tell the kernel to report a version of Windows
      "acpi_osi=\"Windows 2015\""
      "acpi_os_name=\"Microsoft Windows NT\""
      */
    ];
  };
}
