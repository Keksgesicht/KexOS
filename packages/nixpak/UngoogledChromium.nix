{ bindHomeDir, ... }:
{ pkgs-stable, ... }:

let
  name = "UngoogledChromium";
  pkgs = pkgs-stable {};
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = pkgs.ungoogled-chromium; binName = "chromium"; appFile = [
          { src = "chromium-browser"; args.extra = [
            "--password-store=basic" # aggressivly tries to open KDE Wallet
            "--disable-gpu" # even outside the sandbox GPU process crashes and falls back
            # https://github.com/NixOS/nixpkgs/issues/249152
            # https://github.com/NixOS/nixpkgs/issues/299773
          ]; }
        ]; }
      ];
      chromiumCleanupScript = true;
      audio = true;
      time = true;
    };

    dbus.policies = {
      "org.mpris.MediaPlayer2.chromium.*" = "own";
    };

    gpu.enable = true;

    bubblewrap = {
      bind.rw = [
        (bindHomeDir name "/.config/chromium")
      ];
      network = true;
    };
  };
}
