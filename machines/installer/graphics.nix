# This module defines a NixOS installation CD.
# It does contain graphical stuff.
{ pkgs, lib, username, ... }:

{
  imports = [
    ./laptop.nix
    ../../desktop/audio
    ../../desktop/environment-desktop.nix
    ../../desktop/home-manager
    ../../desktop/home-manager/desktop.nix
    ../../desktop/kde-plasma
    ../../desktop/packages.nix
    ../../development
    ../../packages/nixpak
    ../../system/containers/podman.nix
    ../../system/network/desktop
  ];

  users.users."${username}".packages = with pkgs; [
    firefox
    librewolf
    ungoogled-chromium
  ];

  # conflict with iso-image defaults (hardware/x86_64/uefi.nix)
  boot.loader.timeout = lib.mkForce 5;

  # conflict with NetworkManager (system/network/desktop/default.nix)
  networking.wireless.enable = lib.mkForce false;

  # enable login for custom user
  services.displayManager.autoLogin.user = username;
}
