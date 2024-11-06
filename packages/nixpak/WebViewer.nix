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
      Actions=new-private-window;new-window;profile-manager-window
      Categories=Network;WebBrowser
      Exec=${WVname} %U
      GenericName=Web Browser
      Icon=${WVname}
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
