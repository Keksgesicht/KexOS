{ pkgs, username, ... }:

{
  # nix-shell -p "(ventoy.override { withQt5 = true; })"

  users.users."${username}".packages = with pkgs; [
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
