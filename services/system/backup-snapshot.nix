{ self, config, pkgs, lib, ssd-name, hdd-name, ...}:

let
  hn = config.networking.hostName;
  hot-name = "hot_backup";

  pkg-snapper = pkgs.callPackage ../../packages/backup-snapshot.nix {};
  bck-snap-timer = (name: {
    "backup-snapshot@${name}" = {
      # fixes empty config (extends template unit)
      overrideStrategy = "asDropin";
      # this auto enables this unit in the context of systemd
      wantedBy = [ "timers.target" ];
    };
  });

  my-functions = (import ../../nix/my-functions.nix lib);
in
with my-functions;
{
  environment.shellAliases = {
    lb = "${self}/files/scripts/list-backups.sh";
  };

  KexOS.service."backup-snapshot@" = {
    service = {
      description = "Online Backup Job (snapshot - %i)";
      after = [ "mnt-%i.mount" ];
      requires = [ "mnt-%i.mount" ];
      path = with pkgs; [ btrfs-progs gawk util-linux ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkg-snapper}/bin/backup-snapshot.sh %i";
        ReadWritePaths = "/mnt/%i";
        PrivateDevices = "no";
        InaccessiblePaths = lib.mkForce [];
      };
    };
    # one snapshot a day
    timer = {
      description = "Online Backup Timer (snapshot - %i)";
      after = lib.mkForce [];
      timerConfig = lib.mkForce {
        OnCalendar = "*-*-* 06:15:00";
        Persistent = "true";
      };
    };
  };

  systemd = {
    timers = {}
    // (bck-snap-timer ssd-name)
    // (bck-snap-timer hdd-name)
    // (if (hn == "cookieflyer") then (bck-snap-timer hot-name) else {})
    ;

    # https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
    tmpfiles.rules =
    let
      backupLink = mnt: list: (forEach list (e:
        "L+ /mnt/${mnt}/${e}/.backup - - - - ../backup_${mnt}/name/${e}"
      ));
    in
    if (hn == "cookieclicker") then
      backupLink ssd-name [ "appdata" "etc" "home" "var" "vm" ] ++
      backupLink hdd-name [
        "appdata2" "homeBraunJan" "homeGaming" "machines" "resources"
      ]
    else if (hn == "cookiethinker") then
      backupLink ssd-name [ "etc" "home" ] ++
      backupLink hdd-name [ "homeBraunJan" ]
    else
      backupLink ssd-name [ "appdata" "etc" "home" ] ++
      backupLink hdd-name [ "appdata2" ]
    ++ lib.optionals (hn == "cookieflyer") (backupLink hot-name [ "data" ])
    ;
  };
}
