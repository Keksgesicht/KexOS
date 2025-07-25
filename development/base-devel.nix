{ pkgs, username, isDesktop, ... }:

{
  imports = [
    ./git.nix
  ];

  users.users."${username}".packages = with pkgs; [
    binutils
    binwalk
    dig
    fd
    file
    fzf
    jq
    ldns
    lsof
    moar
    nix-output-monitor
    nmap
    psmisc
    pv
    p7zip
    ripgrep
    screen
    sshuttle
    strace
    unixtools.xxd
    unzip
  ] ++ lib.optionals isDesktop [
    (pkgs.writeShellScriptBin "KexOS-DevShell" ''
      usage() {
        echo "$0 path [--suffix=name] args.."
      }

      myOpts=""
      if [ -d "$1" ]; then
        myDir="$1"
        shift
      fi
      if [ "$1" = "--suffix" ]; then
        shift
        myOpts+=" --profile "result-$1""
        shift
      fi
      myOpts+=" $@"

      exec -a nix \
        nix develop ''${myDir} ''${myOpts} --command zsh
    '')
  ];
}
