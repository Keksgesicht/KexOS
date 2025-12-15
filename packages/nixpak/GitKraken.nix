{ sloth, bindHomeDir, ... }:
{ pkgs-latest, ... }:

let
  name = "GitKraken";
  pkgs = pkgs-latest { config.allowUnfree = true; };
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = pkgs.gitkraken; binName = "gitkraken"; appFile = [
          { src = "gitkraken"; dst = "GitKraken"; args.extra = [
            "--enable-features=UseOzonePlatform" "--ozone-platform=wayland"
          ]; }
        ]; }
        pkgs.git
        pkgs.git-lfs
        pkgs.qt6.qtbase
      ];
      chromiumCleanupScript = true;
      time = true;
    };

    bubblewrap = {
      bind.ro = [
        (sloth.concat' sloth.xdgConfigHome "/git")
      ];
      bind.rw = [
        (bindHomeDir name "/.gitkraken")
        (bindHomeDir name "/.config/GitKraken")
        (sloth.concat' sloth.homeDir "/git")
      ];
      sockets.x11 = true; # WTF during startup needed
    };
  };
}
