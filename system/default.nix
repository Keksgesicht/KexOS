{ ... }:

{
  imports = [
    ./base-pkgs.nix
    ./boot-tmpfs.nix
    ./environment.nix
    ./impermanence
    ./openssh
    ./shell-zsh.nix
    ./sudo.nix
    ./systemd.nix
  ];
}
