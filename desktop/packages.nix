{ pkgs, pkgs-stable, username, ... }:

let
  pkgs-sta = pkgs-stable {};
in
{
  # nix-shell -p "(ventoy.override { withQt5 = true; })"

  users.users."${username}".packages = with pkgs; [
    ausweisapp # iptables -I nixos-fw 1 -i wg-server -j ACCEPT
    gnome-decoder
    gnome-calculator
    keepassxc
    meld
    nextcloud-client
    pkgs-sta.okteta
    qrencode
    wireguard-tools
    yubikey-manager
  ];
}
