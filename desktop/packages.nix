{ pkgs, username, ... }:

{
  # nix-shell -p "(ventoy.override { withQt5 = true; })"

  users.users."${username}".packages = with pkgs; [
    ausweisapp # iptables -I nixos-fw 1 -i wg-server -j ACCEPT
    gnome-decoder
    gnome-calculator
    keepassxc
    meld
    nextcloud-client
    okteta
    qrencode
    wireguard-tools
    yubikey-manager
  ];
}
