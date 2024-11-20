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
    yamlfmt
  ];
  lsp-string = lib.strings.concatStringsSep ":" (lib.lists.forEach lsp-pkgs (p:
    "${p}/bin"
  ));

  ide-wrapper = pkgs.writeShellScriptBin "${n}" ''
    export PATH=$PATH:"${lsp-string}"
    exec ${p}/bin/${n} $@
  '';
  ide-merged = pkgs.symlinkJoin {
    pname = "${n}-lsp";
    name = "${n}-with-language-server";
    paths = [
      ide-wrapper
      p
    ];
  };
in
ide-merged
