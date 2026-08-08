{ bindHomeDir, ... }:
{ lib, pkgs-latest, ... }:

let
  name = "WebViewer";
  nameLow = lib.strings.toLower name;

  pkgs = pkgs-latest {};

  WVname = "firefox";
  pkgBase = pkgs."${WVname}";
  pkgWrapper = pkgs.writeShellScriptBin nameLow ''
    exec -a ${nameLow} ${pkgBase}/bin/${WVname} --name ${name} "$@"
  '';
  WVpkg = pkgs.symlinkJoin {
    name = nameLow;
    paths = [ pkgBase pkgWrapper ];
  };

  WVdesk = pkgs.writeTextFile {
    name = "${nameLow}-desktop-file";
    destination = "/share/applications/${WVname}.desktop";
    text = ''
      [Desktop Entry]
      Categories=Network;WebBrowser
      Exec=${nameLow} %U
      GenericName=Web Browser
      Icon=4kyoutubetomp3
      MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;x-scheme-handler/http;x-scheme-handler/https
      Name=${name}
      StartupNotify=true
      StartupWMClass=${name}
      Terminal=false
      Type=Application
      Version=1.4
    '';
  };
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        WVpkg
        { package = WVdesk; binName = nameLow; appFile = [
          { src = WVname; dst = name; }
        ]; }
      ];
      audio = true;
      time  = true;
    };

    dbus.policies = {
      "org.mozilla.firefox.*" = "own";
      "org.mpris.MediaPlayer2.firefox.*" = "own";
    };

    gpu.enable = true;

    bubblewrap = {
      bind.ro = [
        [
          # mozilla.cfg
          ("${WVpkg}/lib/${WVname}")
          ("/app/etc/${WVname}")
        ]
        # USB Webcam
        "/sys/class/video4linux"
        "/sys/devices"
      ];
      bind.dev = [
        # USB Webcam
        "/dev/video0"
        "/dev/video1"
      ];
      bind.rw = [
        (bindHomeDir name "/.mozilla")
      ];
      network = true;
    };
  };
}
