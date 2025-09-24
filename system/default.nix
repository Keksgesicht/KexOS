{ ... }:

{
  imports = [
    ../services/openssh
    ./base-pkgs.nix
    ./boot-tmpfs.nix
    ./environment.nix
    ./impermanence/boot.nix
    ./impermanence/directories.nix
    ./shell-zsh.nix
    ./sudo.nix
    ./systemd.nix
  ];
}
