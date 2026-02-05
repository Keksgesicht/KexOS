{ pkgs, pkgs-latest, username, ... }:

# https://nixos.wiki/wiki/Scanners
let
  pkgs-scan = pkgs-latest { config.allowUnfree = true; };

  epson-gt-x750-config = pkgs.writeTextFile {
    name = "epson-gt-x750.conf";
    destination = "/etc/sane.d/epson-gt-x750.conf";
    text = "usb 0x04b8 0x0119";
  };
in
{

  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs-scan.epkowa
      epson-gt-x750-config
    ];
  };

  users.users."${username}" = {
    packages = [ pkgs.simple-scan ];
    extraGroups = [ "scanner" "lp" ];
  };
}
