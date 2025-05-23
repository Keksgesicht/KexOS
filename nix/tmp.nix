{ ... }:

{
  # running out of space when building larger projects
  # e.g. chromium for robotnix
  # run `nix build` with `--keep-failed` and do this:
  #   $AUTH mkdir -p /var/tmp/nix-daemon
  #   $AUTH rsync -avHAX --remove-source-files /tmp/nix-daemon/ /var/tmp/nix-daemon/
  #   $AUTH mount --bind /var/tmp/nix-daemon /tmp/nix-daem
  systemd = {
    services."nix-daemon".environment.TMPDIR = "/tmp/nix-daemon";
    tmpfiles.rules = [ "q /tmp/nix-daemon 1777 root root 10d" ];
  };
}
