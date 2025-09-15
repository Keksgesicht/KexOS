{ ... }:

{
  # use QEMU to enable transparent program execution for other architectures
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "aarch64_be-linux"
    "armv6l-linux"
    "armv7l-linux"
    "riscv32-linux"
    "riscv64-linux"
  ];
}
