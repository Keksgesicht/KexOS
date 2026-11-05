{ bindHomeDir, ... }:
{ pkgs, ... }:

let
  name = "Ferdium";
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = pkgs.ferdium; binName = "ferdium"; appFile = [
          { args.extra = [
            "--ozone-platform-hint=auto"
            "--enable-features=UseOzonePlatform"
          ]; }
        ]; }
      ];
      variables = {
        LD_LIBRARY_PATH = [
          "${pkgs.pulseaudio}/lib"
        ];
      };
      chromiumCleanupScript = true;
      audio = true;
      time  = true;
    };

    dbus.policies = {
      "org.freedesktop.Notifications" = "talk";
      "org.freedesktop.PowerManagement.Inhibit" = "talk";
    };

    gpu.enable = true;

    bubblewrap = {
      bind.rw = [
        (bindHomeDir name "/.config/Ferdium")
        # FIDO2 Auth
        "/run/pcscd/pcscd.comm"
        "/sys/class/hidraw"
      ];
      bind.dev = [
        # FIDO2 Auth
        "/dev/hidraw8"
        "/dev/hidraw9"
      ];
      network = true;
    };
  };
}
