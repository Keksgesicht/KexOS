{ sloth, bindHomeDir, myKDEpkg, myKDEmount, ... }:
{ pkgs, pkgs-stable, lib, ... }:

let
  name = "DocPDF";
  pkgs-sta = pkgs-stable {};

  okularPkg = (myKDEpkg pkgs.kdePackages.okular "okular" "cp --update=none" [
    "" "part"
  ]);
in
{
  /*
  nixpkgs.config.permittedInsecurePackages = [
    "xpdf-4.05" # pdfdiff
  ];
  */

  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = pkgs.pdfarranger; binName = "pdfarranger"; appFile = [
          { src = "com.github.jeromerobert.pdfarranger";
            args.remove = "%U"; args.extra = "%U"; }
        ]; }
        { package = pkgs-sta.pympress; binName = "pympress"; appFile = [
          { src = "io.github.pympress"; }
        ]; }
        { package = pkgs.xournalpp; binName = "xournalpp"; appFile = [
          { src = "com.github.xournalpp.xournalpp"; args.remove = "-wrapper"; }
        ]; }
        { package = okularPkg; binName = "okular"; appFile = [
          { src = "org.kde.okular"; }
        ]; }
        # PDF tools
        #pkgs.pdfdiff
        pkgs.pdfgrep
        pkgs-sta.ocrmypdf
      ];
      qtKDEintegration = true;
      printing = true;
    };

    dbus.policies = {
      "io.github.pympress" = "own";
      "org.kde.okular.*" = "own";
    };

    bubblewrap = {
      bind.ro = [
        (myKDEmount "okular" "")
        (myKDEmount "okular" "part")
        (sloth.concat' sloth.homeDir "/.local/share/kxmlgui5")
      ];
      bind.rw = [
        (bindHomeDir name "/.config/pdfarranger")
        (bindHomeDir name "/.config/texstudio")
        (bindHomeDir name "/.config/xournalpp")
        (bindHomeDir name "/.local/share/okular")

        (sloth.concat' sloth.xdgDocumentsDir "/Office")
        (sloth.concat' sloth.xdgDocumentsDir "/Studium")
        (sloth.xdgDownloadDir)
        (sloth.concat' sloth.homeDir "/.local/share/kxmlgui5/okular")
        (sloth.concat' sloth.homeDir "/git")
        (sloth.concat' sloth.homeDir "/Module")
      ];
    };
  };
}
