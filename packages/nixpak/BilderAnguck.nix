{ bindHomeDir, myKDEpkg, myKDEmount, ... }:
{ pkgs, pkgs-stable, ... }:

let
  name = "BilderAnguck";

  pkgs-sta = pkgs-stable {};
  gwenviewPkg = (myKDEpkg pkgs.kdePackages.gwenview "gwenview" "cp -n" [ "" ]);
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        # base system
        { package = pkgs-sta.copyq; binName = "copyq"; appFile = [
          { src = "com.github.hluk.copyq"; }
        ]; }
        gwenviewPkg
        # picture editor
        { package = pkgs.gimp; binName = "gimp"; }
        { package = pkgs.inkscape; binName = "inkscape"; appFile = [
          { src = "org.inkscape.Inkscape"; }
        ]; }
        # cli tools for pictures
        pkgs.graphviz
        pkgs.imagemagick
        pkgs.xdot
      ];
      qtKDEintegration = true;
    };

    gpu.enable = true;

    bubblewrap = {
      bind.ro =
      [
        (myKDEmount "gwenview" "")
      ];
      bind.rw = [
        (bindHomeDir name "/.config/copyq")
        (bindHomeDir name "/.config/GIMP")
        (bindHomeDir name "/.config/inkscape")
      ];
    };
  };
}
