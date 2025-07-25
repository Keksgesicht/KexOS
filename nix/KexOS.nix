{ pkgs, username, home-dir, isDesktop, ... }:

let
  kexos-cfg-path = "${home-dir}/nixos-config";
in
{
  users.users."${username}".packages = [
    (pkgs.writeShellScriptBin "KexOS" (''
      if [ $# -lt 1 ]; then
        echo "Missing parameter!"
        exit 1
      fi
      cmd="KexOS-$1"
      shift
      exec -a "$cmd" $cmd $@
    ''))
    (pkgs.writeShellScriptBin "KexOS-rebuild" (''
      usage() {
        echo "$0 [boot|build|repl|test|switch]"
        exit 1
      }

      [ $# -eq 1 ] || usage

      case "$1" in
        build)
          PRFX=""
        ;;
        repl)
          SKIP_UPDATE="y"
          PRFX=""
        ;;
        boot|test|switch)
          PRFX=$AUTH
        ;;
        *)
          usage
        ;;
      esac

      cd ${kexos-cfg-path}/ || exit 2

      if [ -z "$SKIP_UPDATE" ]; then
        read -p 'update input "cookie-pkg" [Y/n]' answer
        if [ "$answer" != "n" ] && [ "$answer" != "N" ]; then
          set -x
          nix flake update "cookie-pkg"
        else
          set -x
        fi
      fi

      $PRFX nixos-rebuild -L --show-trace --flake ${kexos-cfg-path} "$1"
    ''))
    (pkgs.writeShellScriptBin "KexOS-sync" (''
      usage() {
    '' + (if isDesktop
      then ''echo "$0 [up|down|etc] <remote-host>"''
      else ''echo "$0 etc"''
    ) + ''

        exit 1
      }
      kex-sync() {
        set -x
        rsync -avHAXze ssh --delete --exclude='result' --exclude='flake.lock' $@
      }

    '' + (if isDesktop
      then "[ $# -ne 3 ] || usage"
      else "[ $# -ne 2 ] || usage"
    ) + ''

      host="$2"
      dir="nixos-config"

      case "$1" in
    '' + (if isDesktop then ''
        up)
          kex-sync ${kexos-cfg-path}/ ''${host}:''${dir}/
        ;;
        down)
          kex-sync ''${host}:''${dir}/ ${kexos-cfg-path}/
        ;;
    '' else "") + ''
        etc)
          set -x
          $AUTH rsync -rlptv --delete \
            --exclude='/secrets/keys' --exclude='result' \
            ${kexos-cfg-path}/ /etc/nixos/
        ;;
        *) usage ;;
      esac
    ''))
  ];
}
