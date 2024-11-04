{ pkgs, username, isDesktop, ... }:

{
  users.users."${username}".packages = with pkgs; [
    gnome-decoder
    gnome-calculator
    keepassxc
    meld
    nextcloud-client
    okteta
    qrencode
    (ventoy.override {
      withQt5 = isDesktop;
    })
    waypipe
    wireguard-tools
    xorg.xlsclients
    xorg.xorgserver
    xorg.xrandr
    yubikey-manager
  ];
}
