{ pkgs, username, ... }:

# https://nixos.wiki/wiki/Scanners
let
  epson-gt-x750-config = pkgs.writeTextFile {
    name = "epson-gt-x750.conf";
    destination = "/etc/sane.d/epson-gt-x750.conf";
    text = "usb 0x04b8 0x0119";
  };
in
{
  imports = [
    ../../nix/pkgs-unfree.nix
  ];

  nixpkgs.allowUnfreePackages = [
    pkgs.epkowa
    "iscan-data" "iscan-gt"
    "iscan-gt-f720-bundle" "iscan-gt-s600-bundle" "iscan-gt-s650-bundle"
    "iscan-gt-s80-bundle" "iscan-gt-x750-bundle" "iscan-gt-x770-bundle"
    "iscan-gt-x820-bundle" "iscan-nt-bundle" "iscan-perfection-v550-bundle"
    "iscan-v330-bundle" "iscan-v370-bundle"
  ];

  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.epkowa
      epson-gt-x750-config
    ];
  };

  users.users."${username}" = {
    packages = [ pkgs.simple-scan ];
    extraGroups = [ "scanner" "lp" ];
  };
}
