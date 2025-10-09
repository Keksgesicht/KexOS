{ config, pkgs, ... }:

let
  inherit (config.KexOS.service."dummy".service) serviceConfig;
in
{
  systemd.user.services = {
    "xscreensaver" = {
      description = "Screensaver for X11";
      path = with pkgs; [
        bash coreutils findutils gnugrep hwloc iputils kmod
        procps systemd usbutils util-linux xscreensaver
      ];
      environment = {
        GDK_BACKEND = "x11";
      };
      serviceConfig = serviceConfig // {
        ProtectHome = "read-only";
        PrivateDevices = "no";
        TemporaryFileSystem = "%h/.cache";
      };
      script = ''
        xscreensaver --no-splash &
        xss_pid=$!
        sleep 1s
        xscreensaver-command -activate
        wait "$xss_pid"
      '';
    };
  };
}
