{ sloth, bindHomeDir, myKDEpkg, myKDEmount, ... }:
{ config, pkgs, pkgs-stable, ... }:

let
  name = "VideoEdit";
  mlt-ver = "7";

  pkgs-sta = pkgs-stable {};
  gwenviewPkg = (myKDEpkg pkgs.kdePackages.gwenview "gwenview" "cp -n" [ "" ]);
  kdenlivePkg = (myKDEpkg pkgs.kdePackages.kdenlive "kdenlive" "ln -sf" [
    "" "-flatpak" "-layouts"
  ]);
  silence-cutter = (pkgs.callPackage ../silence-cutter.nix {});
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = kdenlivePkg; binName = "kdenlive"; appFile = [
          { src = "org.kde.kdenlive"; }
        ]; }
        { package = pkgs-sta.handbrake; binName = "ghb"; appFile = [
          { src = "fr.handbrake.ghb"; }
        ]; }
        { package = pkgs-sta.audacity; binName = "audacity"; }
        # tools for kdenlive
        # https://github.com/NixOS/nixpkgs/issues/209923
        gwenviewPkg
        pkgs.glaxnimate
        pkgs.mediainfo
        pkgs.mlt
        pkgs.mlt.ffmpeg
        # additional cli tools for video editing
        silence-cutter
      ];
      qtKDEintegration = true;
      audio = true;
    };

    dbus.policies = {
      "org.kde.kdenlive.*" = "own";
    };

    gpu.enable = true;

    bubblewrap = {
      bind.ro = [
        [
          ("${pkgs.mlt}/share/mlt-${mlt-ver}/profiles")
          ("/app/share/mlt-${mlt-ver}/profiles")
        ]
        (myKDEmount "gwenview" "")

        sloth.xdgDocumentsDir
        sloth.xdgMusicDir
        sloth.xdgPicturesDir
      ];
      bind.rw = [
        (bindHomeDir name "/.config/ghb")
        (bindHomeDir name "/.config/kdenlive")
        (sloth.xdgVideosDir)
      ];
    };
  };
}
