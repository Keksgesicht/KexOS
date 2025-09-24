{ options, pkgs, lib, isDesktop, vpn-subnet-v4, vpn-ip-suf
, lan-subnet-v4, lan-ip-suf, ... }:

let
  port = 22;

  ds = "dispatcherScript";
  net-man-opt = options.networking.networkmanager;
in
{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = false;
    listenAddresses = [
      { inherit port; addr = "${vpn-subnet-v4}.${vpn-ip-suf}"; }
      { inherit port; addr = "${lan-subnet-v4}.${lan-ip-suf}"; }
    ];
    settings = {
      LogLevel = "INFO";
      X11Forwarding = false;

      PasswordAuthentication = false;
      PermitEmptyPasswords = false;
      PermitRootLogin =
        if (isDesktop)
        then lib.mkForce "no"
        else lib.mkForce "yes";

      PubkeyAuthentication = true;
      AuthorizedKeysFile = lib.strings.concatStringsSep " " [
        "%h/.config/ssh/authorized_keys"
        "/etc/ssh/authorized_keys.d/%u"
      ];

      LoginGraceTime = "42s";
      StrictModes = true;
      MaxAuthTries = 5;
      MaxSessions = 10;
    };
  };

  networking.networkmanager = if (builtins.hasAttr ds net-man-opt) then {
    "${ds}"."50-sshd".packages = with pkgs; [ systemd ];
  } else {};
}
