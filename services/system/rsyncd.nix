{ secrets-dir, vpn-subnet-v4, vpn-ip-suf, ssd-mnt, hdd-mnt, ... }:

let
  port = 873;
  section31 = (p: {
    path = "${p}/.backup/latest/";
    list = "no";
    "read only" = "yes";
    "auth users" = "backup";
    "hosts allow" = "${vpn-subnet-v4}.2";
    "secrets file" = "${secrets-dir}/keys/rsyncd/server/backup";
  });
in
{
  networking.firewall.interfaces."wg-server".allowedTCPPorts = [ port ];

  services.rsyncd = {
    enable = true;
    inherit port;
    socketActivated = false;
    settings = {
      globalSection = {
        address = "${vpn-subnet-v4}.${vpn-ip-suf}";
        "max connections" = 3;
        "use chroot" = true;
        uid = "root";
        gid = "root";
      };
      sections = {
        etc = section31 "${ssd-mnt}/etc";
        appdata = section31 "${ssd-mnt}/appdata";
        appdata2 = section31 "${hdd-mnt}/appdata2";
      };
    };
  };
}
