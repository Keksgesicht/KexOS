{ self, pkgs, isDesktop, holidayMode, home-dir, username, ... }:

let
  current-system = "/nix/var/nix/profiles/system";
  lock-file-symlink = "/etc/flake-output/nixos-config/flake.lock";
  lock-file-latest = "${current-system}${lock-file-symlink}";

  srvNameCopy = "copy-latest-lock-file";
  localCfgDir = "${home-dir}/nixos-config";
in
{
  environment.etc = {
    "flake-output/nixos-config" = {
      source = self.outPath;
    };
  };

  # https://nixos.wiki/wiki/Automatic_system_upgrades
  system.autoUpgrade = {
    enable = !holidayMode;
    dates = "*-*-2/3 02:22:19";
    randomizedDelaySec = "123min";

    operation =
      if (isDesktop) then "boot"
      else "switch";
    allowReboot = !isDesktop;
    rebootWindow = {
      lower = "02:34";
      upper = "04:32";
    };

    flake = self.outPath;
    flags = [
      "--update-input" "nixpkgs-stable"
      "--update-input" "nixpkgs-unstable"
      "--update-input" "cookie-pkg"
      "--print-build-logs" # -L
      #"--verbose"         # -v
    ];
  };

  systemd.services = {
    "nixos-upgrade".onSuccess = [ "${srvNameCopy}.service" ];
    "${srvNameCopy}".script = ''
      LOCK_FILE="${localCfgDir}/flake.lock"
      rm "$LOCK_FILE"
      cp "${lock-file-latest}" "$LOCK_FILE"
      chown "${username}:${username}" "$LOCK_FILE"
      chmod 644 "$LOCK_FILE"
    '';
  };

  users.users."${username}".packages = if isDesktop then [
    (pkgs.writeShellScriptBin "KexOS-sync" ''
      usage() {
        echo "$0 <remote-host> [up|down]"
        exit 1
      }
      kex-sync() {
        set -x
        rsync -avHAXze ssh --delete --exclude='result' --exclude='flake.lock' $@
      }

      [ $# -ne 3 ] || usage
      host="$1"
      dir="nixos-config"

      case "$2" in
        up)
          kex-sync ~/''${dir}/ ''${host}:''${dir}/
        ;;
        down)
          kex-sync ''${host}:''${dir}/ ~/''${dir}/
        ;;
        *) usage ;;
      esac
    '')
  ] else [];
}
