{ bindHomeDir, ... }:
{ pkgs, ... }:

let
  name = "WebViewer";
  WVname = "librewolf";
  WVpkg = pkgs.writeTextFile {
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
        pkgs.librewolf
        { package = WVpkg; binName = WVname; appFile = [
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
          ("${pkgs.librewolf}/lib/${WVname}")
          ("/app/etc/firefox")
        ]
      ];
      bind.rw = [
        (bindHomeDir name "/.${WVname}")
      ];
      network = true;
    };
  };
}
