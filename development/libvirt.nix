{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = [
    pkgs.gnome-boxes
    pkgs.virt-manager
  ];
}
