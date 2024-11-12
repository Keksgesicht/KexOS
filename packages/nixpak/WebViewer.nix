{ bindHomeDir, ... }:
{ pkgs, ... }:

let
  name = "WebViewer";
  WVname = "firefox";
  WVpkg = pkgs."${WVname}";
  WVdesk = pkgs.writeTextFile {
    name = "webviewer-desktop-file";
    destination = "/share/applications/${WVname}.desktop";
    text = ''
      [Desktop Entry]
      Categories=Network;WebBrowser
      Exec=${WVname} --name ${name} %U
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
        { package = WVdesk; binName = WVname; appFile = [
          { dst = name; }
        ]; }
      ];
      audio = true;
    };

    dbus.policies = {
      "org.mpris.MediaPlayer2.firefox.*" = "own";
    };

    bubblewrap = {
      bind.ro = [
        [
          # mozilla.cfg
          ("${WVpkg}/lib/${WVname}")
          ("/app/etc/firefox")
        ]
      ];
      bind.rw = [
        (bindHomeDir name "/.mozilla")
      ];
      network = true;
    };
  };
}
