{ username, ssd-mnt, home-dir, ... }:

{
  # https://nixos.wiki/wiki/Impermanence#Home_Managing
  # https://github.com/nix-community/impermanence
  environment.persistence."${ssd-mnt}" = {
    hideMounts = true;
    # do not even try using the home-manager impermanence module
    users."${username}".directories = [
      "nixos-config"
      "git/hdd/nix/nixpkgs"
    ];
  };

  systemd.tmpfiles.rules = [
    "f+ ${home-dir}/.zshrc - - - - -"
  ];
}
