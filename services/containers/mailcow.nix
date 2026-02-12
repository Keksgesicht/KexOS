{ pkgs, holidayMode, hdd-name, hdd-mnt, ... }:

# https://docs.mailcow.email/
# https://github.com/mailcow/mailcow-dockerized
# https://www.youtube.com/playlist?list=PLcxL7iznHgfUHJyo4c0CMtaoFJ8S_9iVU

let
  mailcow-updater-script = "./update.sh --force";
  mailcow-path = "${hdd-mnt}/appdata2/mailcow";

  WorkingDirectory = "${mailcow-path}/docker";
  MAILCOW_BACKUP_LOCATION = "${mailcow-path}/backup";

  ReadWritePaths = [ "/var/lib/docker" ];
  serviceConfig = {
    Type = "oneshot";
    inherit WorkingDirectory;
  };
  mailcow-srv-cfg = {
    after    = [ "mnt-${hdd-name}.mount" ];
    requires = [ "mnt-${hdd-name}.mount" ];
  };
in
{
  imports = [
    ../../system/containers/docker.nix
  ];

  virtualisation.docker.logDriver = "local";

  environment.sessionVariables = {
    inherit MAILCOW_BACKUP_LOCATION;
  };

  KexOS.service = {
    "mailcow-update" = {
      service = mailcow-srv-cfg // {
        enable = !holidayMode;
        startAt = "Thu *-*-* 01:12:35";
        path = with pkgs; [
          bash curl docker gawk git iptables jq openssl systemd
        ];
        script = ''
          set +e
          ${mailcow-updater-script} >/dev/null
          if [ "$?" = 2 ]; then
            ${mailcow-updater-script} >/dev/null
          fi
        '';
        serviceConfig = serviceConfig // {
          ReadWritePaths = ReadWritePaths ++ [ WorkingDirectory ];
        };
      };
    };
    "mailcow-backup" = {
      service = mailcow-srv-cfg // {
        startAt = "*-*-* 06:06:06";
        path = with pkgs; [ bash docker findutils gnugrep gnused which ];
        environment = {
          inherit MAILCOW_BACKUP_LOCATION;
        };
        script = ''
          mkdir -p "$MAILCOW_BACKUP_LOCATION"
          helper-scripts/backup_and_restore.sh backup \
            --delete-days 0 all >/dev/null
        '';
        serviceConfig = serviceConfig // {
          ReadWritePaths = ReadWritePaths ++ [ MAILCOW_BACKUP_LOCATION ];
        };
      };
      timer.timerConfig.RandomizedDelaySec = "123sec";
    };
  };
}
