{ sloth, bindHomeDir, ... }:
{ pkgs, ... }:

let
  name = "Office";
  args = { remove = "%U"; extra = "%U"; };
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = pkgs.libreoffice; binName = "libreoffice"; appFile = [
          { inherit args; src = "base"; }
          { inherit args; src = "calc"; }
          { inherit args; src = "draw"; }
          { inherit args; src = "impress"; }
          { inherit args; src = "math"; }
          { inherit args; src = "startcenter"; }
          { inherit args; src = "writer"; }
          { inherit args; src = "xsltfilter"; }
        ]; }
      ];
      printing = true;
    };

    bubblewrap = {
      bind.rw = [
        (bindHomeDir name "/.config/libreoffice")

        (sloth.xdgDocumentsDir)
        (sloth.xdgDownloadDir)
        (sloth.concat' sloth.homeDir "/Module")
      ];
    };
  };
}
