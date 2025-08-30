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
        echo "$0 [boot|build|repl|test|switch] <--update-cookie-pkg> <--reset-lock-file>"
        exit 1
      }

      [ 1 -le $# ] || usage

      case "$1" in
        build)
          PRFX=""
        ;;
        repl)
          SKIP_ANSWER="y"
          PRFX=""
        ;;
        boot|test|switch)
          PRFX=$AUTH
        ;;
        *)
          usage
        ;;
      esac
      ACTION="$1"
      shift

      while [ -n "$1" ]; do
        if [ -n "$SKIP_ANSWER" ]; then
          break
        fi
        case "$1" in
          --update-cookie-pkg)
            KEXOS_DEVSHELL_COOKIEPKG="yes"
          ;;
          --reset-lock-file)
            KEXOS_DEVSHELL_LOCKFILERESET="yes"
          ;;
          *)
            usage
          ;;
        esac
        shift
      done

      cd ${kexos-cfg-path}/ || exit 2

      if [ -n "$KEXOS_DEVSHELL_LOCKFILERESET" ]; then
        PROFILES_PATH="/nix/var/nix/profiles"
        CURRENT_PROFILE="system"
        CFG_OUT_PATH="/etc/flake-output/nixos-config"
        old_flake_lock="$PROFILES_PATH/$CURRENT_PROFILE/$CFG_OUT_PATH"
        cp -fv "$old_flake_lock/flake.lock" "${kexos-cfg-path}/flake.lock"
      fi

      if [ -n "$KEXOS_DEVSHELL_COOKIEPKG" ]; then
        nix flake update "cookie-pkg"
      fi

      set -x
      $PRFX nixos-rebuild -L --show-trace --flake ${kexos-cfg-path} "$ACTION"
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
        rsync -avHAXze ssh --delete --exclude='result' $@
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
