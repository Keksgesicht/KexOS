{ config, lib, inputs, username, ssd-mnt, ssd-name
, hdd-mnt, hdd-name, nvm-mnt, ... }:

let
  link-dir = "/mnt/user";

  mkBootBind = (dir: {
    device = "${ssd-mnt}${dir}";
    fsType = "none";
    options = [ "bind" "nofail" "x-gvfs-hide" ];
    depends = [ "${ssd-mnt}" "/" ];
    neededForBoot = true;
  });

  etc-nmsc = "/etc/NetworkManager/system-connections";
  nm-state-file = "/var/lib/NetworkManager/NetworkManager.state";
in
{
  fileSystems = {
    "${etc-nmsc}" = mkBootBind "${etc-nmsc}";
  };

  # https://github.com/nix-community/impermanence
  environment.persistence = {
    # only start with:
    # /etc -> /mnt/main/etc (BTRFS subvolume)
    # /var -> /mnt/main/var (BTRFS subvolume)
    "${ssd-mnt}" = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections"
        "/etc/nixos"
        "/etc/secureboot"
        "/etc/unCookie"
        "/var/lib/bluetooth"
        "/var/lib/flatpak"
        "/var/lib/fwupd"
        "/var/lib/rasdaemon"
        "/var/lib/systemd/backlight"
        "/var/lib/systemd/timers"
        "/var/lib/waydroid"
        "/var/log"
      ];
      files = [
        "/etc/nix-serve/public-key.pem"
        "/etc/nix-serve/secret-key.pem"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };
  };

  # systemd-machine-id-commit fails on every rebuild without this workaround
  environment.etc."machine-id" = {
    source = "${ssd-mnt}/etc/machine-id";
    mode = "direct-symlink";
  };

  systemd.tmpfiles.rules = [
    # essential
    "L+ ${link-dir}/etc  - - - - ${ssd-mnt}/etc"
    "L+ ${link-dir}/home - - - - ${ssd-mnt}/home"
    "L+ ${link-dir}/var  - - - - ${ssd-mnt}/var"
    # stuff
    "L+ ${link-dir}/backup_${hdd-name} - - - - ${hdd-mnt}/backup_${hdd-name}"
    "L+ ${link-dir}/backup_${ssd-name} - - - - ${ssd-mnt}/backup_${ssd-name}"
    "L+ ${link-dir}/appdata      - - - - ${ssd-mnt}/appdata"
    "L+ ${link-dir}/appdata2     - - - - ${hdd-mnt}/appdata2"
    "L+ ${link-dir}/appdata3     - - - - ${nvm-mnt}/appdata3"
    "L+ ${link-dir}/Games        - - - - ${nvm-mnt}/Games"
    "L+ ${link-dir}/homeBraunJan - - - - ${hdd-mnt}/homeBraunJan"
    "L+ ${link-dir}/homeGaming   - - - - ${hdd-mnt}/homeGaming"
    # useful subvolumes
    "q  ${ssd-mnt}/appdata  - - - - -"
    "q  ${hdd-mnt}/appdata2 - - - - -"
    "q  ${nvm-mnt}/appdata3 - - - - -"
    "q  ${nvm-mnt}/Games        0755 ${username} ${username} - -"
    "q  ${hdd-mnt}/homeBraunJan 0755 ${username} ${username} - -"
    "q  ${hdd-mnt}/homeGaming   0755 ${username} ${username} - -"
    # additional data
    "L+ ${link-dir}/binWin    - - - - ${ssd-mnt}/binWin"
    "L+ ${link-dir}/machines  - - - - ${hdd-mnt}/machines"
    "L+ ${link-dir}/system    - - - - ${ssd-mnt}/system"
    "L+ ${link-dir}/resources - - - - ${hdd-mnt}/resources"
    "L+ ${link-dir}/vm        - - - - ${ssd-mnt}/vm"
    "L+ ${link-dir}/vm2       - - - - ${hdd-mnt}/vm2"

    # suppress warning/info after every reboot
    "f+ /var/db/sudo/lectured/1000 - - - - -"

    # reset permissions for NM connections
    "z ${etc-nmsc} 0700 root root -"
  ]
  # disable WLAN by default on desktop/tower
  ++ lib.optionals (config.networking.networkmanager.enable
                && (config.networking.hostName != "cookiethinker"))
  [
    "C  ${nm-state-file} - - - - ${inputs.self}/files/linux-root${nm-state-file}"
  ];
}
