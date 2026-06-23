{ sloth, appDir, bindHomeDir, ... }:
{ pkgs-stable, ... }:

let
  name = "LibreWolf";
  pkgs = pkgs-stable {};

  arkenfox-lw = (pkgs.callPackage ../arkenfox-user.js.nix {
    patchSet = "LibreWolf";
  });
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = pkgs.librewolf; binName = "librewolf"; }
      ];
      audio = true;
      time  = true;
    };

    #dbus.args = [ "--log" ];
    dbus.policies = {
      "io.gitlab.firefox.*" = "own";
      "io.gitlab.librewolf.*" = "own";
      "org.mozilla.librewolf.*" = "own";
      "org.mpris.MediaPlayer2.firefox.*" = "own";
    };

    bubblewrap = {
      bind.ro = [
        [
          # mozilla.cfg
          ("${pkgs.librewolf}/lib/librewolf")
          ("/app/etc/librewolf")
        ]
        [
          "${arkenfox-lw}"
          (sloth.concat' sloth.homeDir "/.mozilla/user.js")
        ]
        (sloth.mkdir (sloth.concat' sloth.homeDir "/Downloads/read-only"))
      ];
      bind.rw = [
        (bindHomeDir name "/.librewolf")
        [
          (sloth.concat' (appDir name) "/.librewolf")
          (sloth.concat' sloth.homeDir "/.mozilla/librewolf")
        ]
        (sloth.mkdir (sloth.concat' sloth.homeDir "/Downloads/read-write"))
      ];
      network = true;
    };
  };
}
