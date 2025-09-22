{ ... }:

{
  imports = [
    ./base-pkgs.nix
    ./boot-tmpfs.nix
    ./environment.nix
    ./impermanence/boot.nix
    ./impermanence/directories.nix
    ./openssh
    ./shell-zsh.nix
    ./sudo.nix
    ./systemd.nix
  ];
}
