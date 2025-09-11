{ config, pkgs, username, isDesktop, ... }:

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
  ] ++ lib.optionals isDesktop [ config.KexOS.packages."DevShell" ];

  KexOS.packages."DevShell" = pkgs.writeShellScriptBin "KexOS-DevShell" ''
    usage() {
      echo "$0 path [--suffix=name] args.."
    }

    myDir="."
    myOpts=""
    resPath=""
    if [ -d "$1" ]; then
      myDir="$1"
      shift
    fi
    if [ "$1" = "--suffix" ]; then
      shift
      if [ -z "$1" ]; then
        usage
      fi
      res_dir=$(dirname "$1")
      res_file=$(basename "$1")
      shift
      resPath="$res_dir/result-$res_file"
    fi
    myOpts+="$@"

    if [ -z "$resPath" ]; then
      exec -a nix \
        nix develop "$myDir" $myOpts \
        --command zsh
    else
      exec -a nix \
        nix develop "$myDir" $myOpts \
        --profile "$resPath" \
        --command zsh
    fi
  '';
}
