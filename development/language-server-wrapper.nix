pkgs: lib: p: n:
let
  lsp-pkgs = with pkgs; [
    # Bash
    bash-language-server
    shfmt
    # C/C++
    clang-tools
    # Java
    jdt-language-server
    # JSON
    jq
    # LaTeX
    texlab
    # Markdown
    marksman
    # Nix
    nil
    # Python
    python3Packages.python-lsp-server
    ruff
    # XML
    lemminx
    libxml2
    # YAML
    yaml-language-server
    yamlfmt
  ];

  lsp-path = "/usr/local/lsp";
  ide-wrapper = pkgs.writeShellScriptBin "${n}" ''
    export PATH=$PATH:${lsp-path}/bin
    exec ${p}/bin/${n} $@
  '';

  lsp-data = {
    inherit lsp-path;
    lsp = pkgs.symlinkJoin {
      name = "lsp-pkgs-joined";
      paths = lsp-pkgs;
    };
    ide = pkgs.symlinkJoin {
      pname = "${n}-lsp";
      name = "${n}-with-language-server";
      paths = [ ide-wrapper p ];
    };
  };
in
lsp-data
