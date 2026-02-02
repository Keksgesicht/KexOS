{ sloth, bindHomeDir, myKDEpkg, myKDEmount, ... }:
{ pkgs, pkgs-stable, lib, ... }:

let
  name = "DocPDF";
  pkgs-sta = pkgs-stable {};

  okularPkg = (myKDEpkg pkgs.kdePackages.okular "okular" "cp -n" [
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
          { src = "com.github.xournalpp.xournalpp"; }
        ]; }
        okularPkg
        # PDF tools
        #pkgs.pdfdiff
        pkgs.pdfgrep
        pkgs.ocrmypdf
      ];
      qtKDEintegration = true;
      printing = true;
    };

    dbus.policies = {
      "io.github.pympress" = "own";
    };

    bubblewrap = {
      bind.ro = [
        (myKDEmount "okular" "")
        (myKDEmount "okular" "part")
        (sloth.concat' sloth.homeDir "/texmf") # TUDa Logo and other templates
      ];
      bind.rw = [
        (bindHomeDir name "/.config/pdfarranger")
        (bindHomeDir name "/.config/texstudio")
        (bindHomeDir name "/.config/xournalpp")

        (sloth.concat' sloth.xdgDocumentsDir "/Office")
        (sloth.concat' sloth.xdgDocumentsDir "/Studium")
        (sloth.xdgDownloadDir)
        (sloth.concat' sloth.homeDir "/git")
        (sloth.concat' sloth.homeDir "/Module")
      ];
    };
  };

  environment.shellAliases = {
    "latexmk"  = "latexmk  -synctex=1 -pdf -silent";
    "lualatex" = "lualatex -synctex=1 -interaction=nonstopmode";
    "pdflatex" = "pdflatex -synctex=1 -interaction=nonstopmode";
    "xelatex"  = "xelatex  -synctex=1 -interaction=nonstopmode";
  };
}
