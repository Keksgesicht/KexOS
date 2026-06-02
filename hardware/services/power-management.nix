{ config, pkgs, lib, system, username, ... }:

# https://nixos.wiki/wiki/Power_Management
# https://wiki.archlinux.org/title/CPU_frequency_scaling
let
  mobileSystem = (config.networking.hostName == "cookiethinker");

  cpu-gov-pkg = pkgs.writeShellScriptBin "set-cpu-governor" ''
    case "$1" in
      "powersave" | "performance" | "ondemand")
        for f in $(ls /sys/bus/cpu/devices/cpu*/cpufreq/scaling_governor); do
          echo "$1" > "$f"
        done
      ;;
      *)
        echo "\"$1\" currently not allowed!"
      ;;
    esac
  '';
  cpu-gov-script = "${cpu-gov-pkg}/bin/set-cpu-governor";
in
{
  powerManagement = {
    enable = true;
    # https://search.nixos.org/options?channel=unstable&show=powerManagement.cpuFreqGovernor
    # /sys/bus/cpu/devices/cpu0/cpufreq/scaling_governor
    cpuFreqGovernor = "ondemand";
  };

  boot.kernelParams = []
  ++ lib.optionals (system == "x86_64-linux") [
    "amd_pstate=guided"
  ];

  # https://nixos.wiki/wiki/Laptop
  # https://linrunner.de/tlp/settings/index.html
  services = {
    power-profiles-daemon.enable =
      if (mobileSystem) then (lib.mkForce false)
      else (lib.mkOptionDefault false);
    tlp = {
      enable = mobileSystem;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC   = "ondemand";
        CPU_ENERGY_PERF_POLICY_ON_AC = "ondemand";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;

        CPU_SCALING_GOVERNOR_ON_BAT   = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 33;

        # helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 42;
        STOP_CHARGE_THRESH_BAT0  = 88;
      };
    };
  };

  # disable hibernation for systems with encrypted swap
  # https://forum.manjaro.org/t/howto-disable-turn-off-hibernate-completely/8033
  systemd.sleep.settings.Sleep = {
    AllowHibernation = false;
    AllowHybridSleep = false;
    AllowSuspendThenHibernate = false;
  };
  services.logind.settings.Login = {
    HandleHibernateKeyLongPress = "ignore";
    HandleHibernateKey = "ignore";
  };

  # toggle performance/powersave with privileges
  security.sudo-rs.extraRules = [ {
    users = [ username ];
    commands = [
      { options = [ "NOPASSWD" ]; command = "${cpu-gov-script} performance"; }
      { options = [ "NOPASSWD" ]; command = "${cpu-gov-script} ondemand"; }
      { options = [ "NOPASSWD" ]; command = "${cpu-gov-script} powersave"; }
    ];
  } ];
  programs.zsh.interactiveShellInit = ''
    cpu-toggle-governor() {
      CPUGOV=$(cat /sys/bus/cpu/devices/cpu0/cpufreq/scaling_governor)
      case "$CPUGOV" in
        "performance") sudo ${cpu-gov-script} "ondemand" ;;
        "ondemand")    sudo ${cpu-gov-script} "powersave" ;;
        "powersave")   sudo ${cpu-gov-script} "performance" ;;
        *)             sudo ${cpu-gov-script} "ondemand" ;;
      esac
    }
  '';
}
