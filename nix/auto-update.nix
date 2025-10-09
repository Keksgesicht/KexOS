{ self, config, isDesktop, holidayMode, home-dir, username, ... }:

let
  current-system = "/nix/var/nix/profiles/system";
  lock-file-symlink = "/etc/flake-output/nixos-config/flake.lock";
  lock-file-latest = "${current-system}${lock-file-symlink}";

  srvNameCopy = "copy-latest-lock-file";
  localCfgDir = "${home-dir}/nixos-config";

  timerConfig = config.KexOS.service."dummy".timer;
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
    dates = "Tue *-*-* 02:22:19";
    randomizedDelaySec = "123min";
    persistent = true;

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
      "--update-input" "flake-registry"
      "--update-input" "nixpkgs-stable"
      "--update-input" "nixpkgs-unstable"
      "--update-input" "cookie-pkg"
      "--print-build-logs" # -L
      #"--verbose"         # -v
    ];
  };

  systemd.services = {
    "nixos-upgrade" = {
      onSuccess = [ "${srvNameCopy}.service" ];
      serviceConfig = {
        CPUSchedulingPolicy = "idle";
        IOSchedulingClass = "idle";
        IOSchedulingPriority = 7;
      };
    };
    "${srvNameCopy}".script = ''
      LOCK_FILE="${localCfgDir}/flake.lock"
      rm "$LOCK_FILE"
      cp "${lock-file-latest}" "$LOCK_FILE"
      chown "${username}:${username}" "$LOCK_FILE"
      chmod 644 "$LOCK_FILE"
    '';
  };
  systemd.timers."nixos-upgrade" = timerConfig;
}
