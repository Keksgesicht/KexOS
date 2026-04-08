{ config, pkgs, username, cookie-dir, home-dir, isDesktop, ... }:

let
  kexos-pkgs = config.KexOS.packages;
  kexos-cfg-remote = "/tmp/KexOS-remote-config";
  kexos-cfg-path = "${home-dir}/nixos-config";
  kexos-cfg-old = "/nix/var/nix/profiles/system/etc/flake-output/nixos-config";
in
{
  KexOS.packages = {
    "meta-wrapper" = pkgs.writeShellScriptBin "KexOS" (''
      if [ $# -lt 1 ]; then
        echo "Missing parameter!"
        exit 1
      fi
      cmd="KexOS-$1"
      shift
      exec -a "$cmd" $cmd $@
    '');

    "rebuild" = pkgs.writeShellScriptBin "KexOS-rebuild" (''
      usage() {
        echo "$0 [boot|build|repl|test|switch] <--update-cookie-pkg> <--reset-lock-file> <--target-host [hostname]>"
        exit 1
      }

      [ 1 -le $# ] || usage

      case "$1" in
        build)
          WORKS_LOCAL="y"
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
        case "$1" in
          --update-cookie-pkg)
            if [ -z "$SKIP_ANSWER" ]; then
              KEXOS_REBUILD_COOKIEPKG="yes"
            else
              echo "ignoring updating cookie-pkg because of repl"
            fi
          ;;
          --reset-lock-file)
            if [ -z "$SKIP_ANSWER" ]; then
              KEXOS_REBUILD_LOCKFILERESET="yes"
            else
              echo "ignoring updating cookie-pkg because of repl"
            fi
          ;;
          --target-host)
            shift
            KEXOS_REBUILD_OUTPUT="#$1"
            KEXOS_REBUILD_REMOTE_HOST="$1"
            NIX_SSHOPTS="-i /root/.secrets/ssh/id_backup"
            export NIX_SSHOPTS
            if [ -z "$SKIP_ANSWER" ] && [ -z "$WORKS_LOCAL" ]; then
              ACTION+=" --target-host root@$1"
              PRFX+=" --preserve-env=NIX_SSHOPTS"
            fi
          ;;
          *)
            usage
          ;;
        esac
        shift
      done

      KEXOS_CFG_PATH=$(realpath "${kexos-cfg-path}")
      cd "''${KEXOS_CFG_PATH}/" || exit 21
      set -e

      if [ -n "$KEXOS_REBUILD_LOCKFILERESET" ]; then
        if [ -n "$KEXOS_REBUILD_REMOTE_HOST" ]; then
          rsync -te ssh \
            "$KEXOS_REBUILD_REMOTE_HOST":"''${KEXOS_CFG_PATH}/flake.lock" \
            "''${KEXOS_CFG_PATH}/flake.lock"
        else
          cp -fv "${kexos-cfg-old}/flake.lock" "''${KEXOS_CFG_PATH}/flake.lock"
        fi
      fi

      if [ -n "$KEXOS_REBUILD_COOKIEPKG" ]; then
        if [ -n "$KEXOS_REBUILD_REMOTE_HOST" ]; then
          $AUTH rsync -rlptue "ssh $NIX_SSHOPTS" \
            root@"$KEXOS_REBUILD_REMOTE_HOST":${cookie-dir}/ ${cookie-dir}/
          $AUTH rsync -rlpte "ssh $NIX_SSHOPTS" --delete ${cookie-dir}/ \
            root@"$KEXOS_REBUILD_REMOTE_HOST":${cookie-dir}/
        fi
        nix flake update "cookie-pkg"
      fi

      kexos-rebuild() {
        set -x
        $PRFX nixos-rebuild --flake "''${KEXOS_CFG_PATH}''${KEXOS_REBUILD_OUTPUT}" \
          $ACTION "$@"
      }

      if [ -n "$SKIP_ANSWER" ]; then
        kexos-rebuild -L --show-trace
      else
        $PRFX true || exit 47
        kexos-rebuild --log-format internal-json |& nom --json
      fi
    '');

    "sync" = pkgs.writeShellScriptBin "KexOS-sync" (''
      usage() {
    '' + (if isDesktop
      then ''echo "$0 [up|down|diff|etc] <remote-host>"''
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
        diff)
          mkdir -p ${kexos-cfg-remote}/
          kex-sync ''${host}:''${dir}/ ${kexos-cfg-remote}/
          diff --color=auto -r ${kexos-cfg-path} ${kexos-cfg-remote} -x .git
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
    '');
  };

  users.users."${username}".packages = [
    kexos-pkgs."meta-wrapper"
    kexos-pkgs."rebuild"
    kexos-pkgs."sync"
  ];
}
