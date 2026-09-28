{ pkgs, ... }:

let
  log-path = "/var/log/btrfs-scrub";
  btrfs-bin = "${pkgs.btrfs-progs}/bin/btrfs";
  btrfs-pkg = pkgs.writeShellScriptBin "btrfs" ''
    escape_path() {
      local path=$1
      path=''${path#/}
      path=''${path//\//-}
      printf '%s\n' "''${path:-"-"}"
    }

    btr-exit() {
      exec ${btrfs-bin} "$@"
    }

    [ "$#" != 3 ] && btr-exit "$@"
    [ "$1" != "scrub" ] && btr-exit "$@"
    [ "$2" != "status" ] && btr-exit "$@"
    BTRFS_PATH="$3"
    ESC_PATH="${log-path}/$(escape_path "$BTRFS_PATH")"

    if ${btrfs-bin} scrub status "$BTRFS_PATH" | grep -q 'no stats available'; then
      if [ -f "$ESC_PATH" ]; then
        cat "$ESC_PATH"
        exit 0
      else
        btr-exit "$@"
      fi
    elif ${btrfs-bin} scrub status "$BTRFS_PATH" | grep -q 'ERROR: not a btrfs filesystem:'; then
      btr-exit "$@"
    else
      ${btrfs-bin} scrub status "$BTRFS_PATH" | tee "$ESC_PATH"
    fi
  '';
in
{
  services.checkmk-agent = {
    enable = true;
    plugins = [
      "mk_inventory.linux"
      "netstat.linux"
      "smart_posix"
    ];
    externalPlugins = [
      # https://exchange.checkmk.com/p/apcaccess
      (pkgs.fetchurl {
        url = "https://exchange.checkmk.com/packages/apcaccess/2374/apcaccess-7.0.1.mkp";
        hash = "sha256-YB4p7EQZLvbzODhWcZi1wXKmkuD2nR/aCFc49a/a1Hs=";
      })
      # https://exchange.checkmk.com/p/btrfs-health
      (pkgs.fetchurl {
        url = "https://exchange.checkmk.com/packages/btrfs-health/1992/btrfs_health-2.0.10.mkp";
        hash = "sha256-jo1bOtUiVVtqptLT7pRwl0H7gT5cLbYiSHZnl4cgbQY=";
      })
    ];
  };

  # make plugin happy
  environment.etc."apcupsd/apcupsd.conf".text = "";

  systemd.services."checkmk-agent@".path = with pkgs; [
    apcupsd btrfs-pkg dmidecode findutils net-tools pciutils smartmontools
  ];

  systemd.services."checkmk-agent@".serviceConfig.ReadWritePaths = [ log-path ];

  systemd.tmpfiles.rules = [
    "d /etc/check_mk                 0755 root root -"
    "d /var/lib/check_mk_agent       0755 root root -"
    "d /var/lib/check_mk_agent/cache 0755 root root -"
    "d /var/lib/check_mk_agent/job   0755 root root -"
    "d ${log-path}                   0700 root root -"
  ];
}
