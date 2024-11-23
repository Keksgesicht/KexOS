{ sloth, bindHomeDir, myKDEpkg, myKDEmount, ... }:
{ pkgs-latest, lib, ... }:

let
  name = "DocPDF";
  latexSet = "work";

  pkgs = pkgs-latest {};
  tl = pkgs.texlive;

  pkgsTexLive = (tl.combine ({
    inherit (tl)
      scheme-small
      latexmk
      standalone
    ;
  } // (lib.optionals (latexSet == "work") {
    inherit (tl)
      # TUDa comperate design
      tuda-ci
      adjustbox
      anyfontsize
      environ
      fontaxes
      pdfx
      roboto
      urcls
      xcharter
      xstring
      # additional packages
      csquotes
      datetime
      fmtcount
      fontawesome
      forest
      glossaries
      numprint
      pgf-umlsd
      siunitx
      xmpincl
    ;
  })));



  wrapperLaTeX = (name: args: let
    strFunc = lib.strings;
    npOut1 = strFunc.head (strFunc.splitString "-" pkgsTexLive);
    npOut2 = strFunc.removePrefix npOut1 pkgsTexLive;
    argStr = strFunc.concatStringsSep ", " (lib.lists.forEach args (e:
      "\"${e}\""
    ));
  in
  pkgs.writers.writePython3Bin "my-${name}" {
        libraries = [];
  } ''
    import sys
    import os
    wrappedCmd = "${npOut1}"
    wrappedCmd += "${npOut2}"
    wrappedCmd += "/bin/${name}"
    wrappedArgs = [wrappedCmd]
    wrappedArgs += [${argStr}]
    wrappedArgs += sys.argv[1:]
    os.execv(wrappedCmd, wrappedArgs)
  '');
  pkgsLaTeX = [
    pkgsTexLive
    (wrapperLaTeX "mklatex"  [ "-synctex=1" "-pdf" "-silent" ])
    (wrapperLaTeX "lualatex" [ "-synctex=1" "-interaction=nonstopmode" ])
    (wrapperLaTeX "pdflatex" [ "-synctex=1" "-interaction=nonstopmode" ])
    (wrapperLaTeX "xelatex"  [ "-synctex=1" "-interaction=nonstopmode" ])
  ];

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
        { package = pkgs.pympress; binName = "pympress"; appFile = [
          { src = "io.github.pympress"; }
        ]; }
        { package = pkgs.texstudio; binName = "texstudio"; appFile = [
          { args.remove = "%F"; args.extra = "%F"; }
        ]; }
        { package = pkgs.xournalpp; binName = "xournalpp"; appFile = [
          { src = "com.github.xournalpp.xournalpp"; }
        ]; }
        okularPkg
        # PDF tools
        #pkgs.pdfdiff
        pkgs.pdfgrep
        pkgs.ocrmypdf
      ]
      # LaTeX stuff
      ++ pkgsLaTeX
      ;
      qtKDEintegration = true;
      printing = true;
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
}
