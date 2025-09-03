{ pkgs, lib, modulesPath, system, isDesktop, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    #./development/amdgpu-rocm.nix
    #./development/hackrf.nix
    ./development/htop.nix
    ./development/utils.nix
    ./security/watchdog.nix
    ./services/btrfs.nix
  ]
  ++ lib.optionals (system == "aarch64-linux") [
    #./aarch64/binfmt.nix
  ]
  ++ lib.optionals (system == "x86_64-linux") [
    #./x86_64/binfmt.nix
  ];

  boot.kernelPackages =
    if (isDesktop) then
      pkgs.linuxPackages_latest
    else
      pkgs.linuxPackages;

  specialisation = if (isDesktop) then {
    "Kernel-LTS".configuration = {
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
    };
  } else {};
}
