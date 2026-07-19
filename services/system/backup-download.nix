{ pkgs, lib, myDomain, hdd-mnt, hdd-name, ... }:

let
  th = (name: "${name}.internal.${myDomain}");
  bd-pkg = (pkgs.callPackage ../../packages/backup-download.nix {});
  bd-units = (sn: {
    systemd.tmpfiles.rules = [ "d  ${hdd-mnt}/machines/${sn}" ];
    KexOS.service."backup-download@${sn}" = {
      service = {
        stopIfChanged = false;
        restartIfChanged = false;
        after = [ "podman-pihole.service" ];
        path = with pkgs; [ gnutar gzip openssh rsync ];
        requires = [ "mnt-${hdd-name}.mount" ];
        description = "Generates Backups from different Remote Systems";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${bd-pkg}/bin/backup-download.sh ${sn} ${th sn}";
          ProtectHome = "no";
          TemporaryFileSystem = [
            "/etc:ro" "/home:ro" "/run/user:ro"
            "/root"
          ];
          BindReadOnlyPaths = [
            "/etc/ssh/ssh_config"
            "/root/.config/ssh"
            "/root/.secrets/ssh"
          ];
          ReadWritePaths = "${hdd-mnt}/machines/${sn}";
          InaccessiblePaths = lib.mkForce [];
        };
      };
      timer.timerConfig.OnCalendar = "*-*-* 08:15:00";
    };
  });
in
{
  config = lib.mkMerge [
    ({ systemd.tmpfiles.rules = [ "q  ${hdd-mnt}/machines" ]; })
    (bd-units "cookieflyer")
    (bd-units "cookiemailer")
    (bd-units "cookiepi")
  ];

  /*
   * manual preparation steps:
   *   sudo -i
   *
   *   mkdir -p ~/.secrets/ssh
   *   ssh-keygen
   */
}


