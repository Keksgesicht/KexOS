{ bindHomeDir, ... }:
{ pkgs, ... }:

let
  name = "Signal";
  pkg-name = "signal-desktop";
in
{
  services.pipewire.alsa.enable = true;

  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = pkgs."${pkg-name}"; binName = pkg-name; appFile = [
          { src = "signal"; args.remove = "--use-tray-icon"; }
        ]; }
        pkgs.qt6.qtbase
      ];
      variables = {
        SIGNAL_USE_TRAY_ICON = "0";
        SIGNAL_START_IN_TRAY = "0";
      };
      chromiumCleanupScript = true;
      audio = true;
      time  = true;
    };

    dbus.policies = {
      "org.freedesktop.Notifications" = "talk";
      "org.freedesktop.PowerManagement.Inhibit" = "talk";
    };

    bubblewrap = {
      bind.ro = [
        "/etc/alsa/conf.d"
        "/etc/static/alsa/conf.d"
      ];
      bind.rw = [
        (bindHomeDir name "/.config/Signal")
      ];
      network = true;
      sockets.x11 = true; # wayland does not work :(
    };
  };
}
