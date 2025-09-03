{ ... }:

{
  imports = [
    ./audio
    ./environment-desktop.nix
    ./flatpak.nix
    ./home-manager
    ./home-manager/desktop.nix
    ./impermanence
    ./kde-plasma.nix
    ./openssh.nix
    ./packages.nix
    ./printing.nix
    ./sd-user.nix
    ../packages/nixpak
    ../services/user/xscreensaver.nix
  ];
}
