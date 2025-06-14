{ sloth, appDir, ... }:
{ pkgs, ssd-mnt, home-dir, ... }:

let
  name = "DevShell";
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = with pkgs; [
        htop git nix rsync
      ];
      xdg-portal = false;
    };

    dbus.enable = false;
    gpu.enable = false;

    bubblewrap = {
      network = false;
      bind.ro = [
        # system
        ("/etc/nix/nix.conf")
        ("/nix/var")
        # user
        (sloth.concat' sloth.homeDir "/texmf")
        # maybe read-write
        (sloth.concat' sloth.homeDir "/devel")
        (sloth.concat' sloth.homeDir "/git")
      ];
      bind.rw = [
        # .zhistory
        [
          (sloth.mkdir (appDir name))
          ("${ssd-mnt}${home-dir}")
        ]
      ];
    };
  };
}
