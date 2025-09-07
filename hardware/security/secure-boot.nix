{ options, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    sbctl
  ];

  # https://nixos.wiki/wiki/Secure_Boot
  # https://github.com/nix-community/lanzaboote
  boot = if (builtins.hasAttr "lanzaboote" options.boot) then {
    bootspec.enable = true;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      # $AUTH sbctl create-keys
      pkiBundle = "/etc/secureboot";
    };
  } else {};
}
