{ config, pkgs, lib, username, home-dir, ssd-mnt, secrets-dir, secrets-pkg, ... }:

let
  hn = config.networking.hostName;
  user-pw-path = "${secrets-dir}/keys/passwd/${username}";
  keyPathClient = secrets-pkg + "/ssh/client";
in
{
  imports = [
    ../nix/secrets-pkg.nix
  ];

  users.groups."${username}".gid = 1000;
  users.users."${username}" = {
    isNormalUser = true;
    description = "Jan B.";
    shell = pkgs.zsh;
    uid = 1000;
    group = "${username}";
    home = "${home-dir}";
    homeMode = "700";
    createHome = true;
    extraGroups = [ "wheel" ];
    # Don't forget to create a password with `mkpasswd`.
    hashedPasswordFile = "${ssd-mnt}${user-pw-path}";
    # remote access
    openssh.authorizedKeys.keyFiles = []
      ++ lib.optionals (hn != "cookieclicker")
         [( keyPathClient + "/id_cookieclicker.pub" )]
      ++ lib.optionals (hn != "cookiethinker")
         [( keyPathClient + "/id_cookiethinker.pub" )]
    ;
  };
}
