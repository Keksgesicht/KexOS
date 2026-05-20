{ config, pkgs, username, isDesktop, ... }:

let
  kill-exe = "${pkgs.util-linux.bin}/bin/kill";
  sleep-exe = "${pkgs.coreutils}/bin/sleep";
  my-kill = pkgs.writeShellScriptBin "my_kill" ''
    PID="$1"
    if [ -z "$PID" ] || ! [ -d "/proc/$PID" ]; then
      exit 1
    fi
    kill_func() {
      SIG="$1"
      PID="$2"
      echo "Sending $SIG to $PID"
      ${kill-exe} "$SIG" "$PID"
      ${sleep-exe} 1s
      [ -d "/proc/$PID" ] || exit 0
    }
    kill_func  '-3' "$PID"
    kill_func  '-2' "$PID"
    kill_func  '-1' "$PID"
    kill_func '-15' "$PID"
    kill_func  '-9' "$PID"
    exit 9
  '';
in
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
    # custom packages/executeables
    my-kill
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
          myOpts+=" $1"
        ;;
      esac
      shift
    done

    kexos-devshell() {
      exec nom develop "$myDir" $myOpts $@ --command $cmd
    }

    if [ -z "$resPath" ]; then
      kexos-devshell
    else
      kexos-devshell --profile "$resPath"
    fi
  '';
}
