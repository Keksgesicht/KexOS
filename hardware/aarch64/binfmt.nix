{ ... }:

{
  # use QEMU to enable transparent program execution for other architectures
  boot.binfmt.emulatedSystems = [
    # RISC-V
    "riscv32-linux"
    "riscv64-linux"
    # x86
    "i386-linux"
    "i486-linux"
    "i586-linux"
    "i686-linux"
    "x86_64-linux"
  ];
}
