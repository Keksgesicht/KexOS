{ config, pkgs, lib, ssd-name, hdd-name, ...}:

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
  environment.systemPackages = with pkgs; [
    (callPackage ../../packages/list-backups.nix {})
  ];

  systemd = {
    services = {
      # one snapshot a day
      "backup-snapshot@" = {
        description = "Online Backup Job (snapshot - %i)";
        after = [ "mnt-%i.mount" ];
        requires = [ "mnt-%i.mount" ];
        path = with pkgs; [ btrfs-progs gawk util-linux ];
        serviceConfig = {
          Type      = "oneshot";
          ExecStart = "${pkg-snapper}/bin/backup-snapshot.sh %i";
          PrivateTmp   = "yes";
          ProtectHome  = "yes";
          ProtectClock = "yes";
          ProtectProc  = "invisible";
        };
      };
    };

    timers = {
      # one snapshot a day
      "backup-snapshot@" = {
        description = "Online Backup Timer (snapshot - %i)";
        timerConfig = {
          OnCalendar = "*-*-* 06:15:00";
          # also run when system was offline (like anacron)
          Persistent = "true";
        };
      };
    }
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
      backupLink ssd-name [
        "appdata"
        "etc"
        "home"
        "var"
        "vm"
      ] ++
      backupLink hdd-name [
        "appdata2"
        "homeBraunJan"
        "homeGaming"
        "machines"
        "resources"
      ]
    else if (hn == "cookiethinker") then
      backupLink ssd-name [ "etc" "home" ]
      ++
      backupLink hdd-name [ "homeBraunJan" ]
    else
      backupLink ssd-name [
        "appdata"
        "etc"
        "home"
      ] ++
      backupLink hdd-name [
        "appdata2"
      ]
    ++ lib.optionals (hn == "cookieflyer") (backupLink hot-name [ "data" ])
    ;
  };
}
