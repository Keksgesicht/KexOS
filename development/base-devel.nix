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

    cmd="zsh"
    myDir="."
    myOpts=""
    resPath=""

    if [ -d "$1" ]; then
      myDir="$1"
      shift
    fi
    while [ -n "$1" ]; do
      case "$1" in
        --suffix)
          shift
          if [ -z "$1" ]; then
            usage
          fi
          res_dir=$(dirname "$1")
          res_file=$(basename "$1")
          resPath="$res_dir/result-$res_file"
        ;;
        --nice)
          cmd="nice $cmd"
        ;;
        *)
          myOpts+="$1"
        ;;
      esac
      shift
    done

    kexos-devshell() {
      exec -a nix nix develop "$myDir" $myOpts $@ --command $cmd
    }

    if [ -z "$resPath" ]; then
      kexos-devshell
    else
      kexos-devshell --profile "$resPath"
    fi
  '';
}
