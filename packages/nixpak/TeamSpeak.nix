{ bindHomeDir, ... }:
{ config, pkgs-latest, lib, username, home-dir, ... }:

let
  name = "TeamSpeak";
  tsEnable = config.nixpak."${name}".enable;

  app-dir = "${home-dir}/.var/app/${name}/teamspeak-client";
  nixpak-pkg = config.nixpak."${name}".output.env;

  pkgs = pkgs-latest { config.allowUnfree = true; };
  ts-app = pkgs.teamspeak6-client;
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        pkgs.steam-run
      ];
      variables = {
        SSL_CERT_DIR = "/etc/ssl/certs";
        LD_LIBRARY_PATH = lib.makeLibraryPath ((with pkgs; [
          udev libGL libvdpau
          libpulseaudio pipewire
        ]) ++ ts-app.propagatedBuildInputs ++ (with pkgs; [
          alsa-lib at-spi2-core cairo dbus expat glib libdrm libnotify nspr nss pango util-linux
          libx11 libxcb libxcomposite libxdamage libxext libxfixes libxkbcommon libxrandr libxrender
        ]));
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
      bind.ro = [
        "/sys/bus"
        "/sys/class"
        "/sys/dev"
        "/sys/devices"
      ];
      bind.rw = [
        # https://teamspeak.com/en/downloads
        (bindHomeDir name "/teamspeak-client")
        (bindHomeDir name "/.config/TeamSpeak")
      ];
      network = true;
      # otherwise navigating some setting pages (e.g. Audio, Whispers, ...) will crash the app
      sockets.x11 = true;
    };
  };

  home-manager.users."${username}".xdg.desktopEntries = if tsEnable then {
    "${name}" = {
      inherit name;
      exec = "${nixpak-pkg}/bin/${name} steam-run ${app-dir}/TeamSpeak @@u %u @@";
      icon = "teamspeak-client";
      categories = [ "AudioVideo" "Audio" "Chat" "Network" ];
      comment = "TeamSpeak Voice Communication Client";
      mimeType = [ "x-scheme-handler/ts3server" "x-scheme-handler/teamspeak" ];
      startupNotify = false;
    };
  } else {};
}
