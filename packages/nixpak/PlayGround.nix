{ sloth, appDir, ... }:
{ pkgs, ssd-mnt, home-dir, ... }:

let
  name = "PlayGround";
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = with pkgs; [
        htop git nix rsync
      ];
      variables = {
        #GDK_BACKEND = "x11";
        #QT_QPA_PLATFORM = "wayland";
      };
      time = true;
      audio = true;
      #printing = true;
      qtKDEintegration = true;
      chromiumCleanupScript = true;
    };

    dbus.enable = true;
    dbus.policies = {
      #"org.mpris.MediaPlayer2.*" = "own";
      #"org.mpris.MediaPlayer2.*.*" = "own";
    };
    #dbus.args = [ "--log" ];

    gpu.enable = true;

    bubblewrap = {
      network = true;
      sockets = {
        x11 = true;
        wayland = true;
      };
      bind.dev = [
        # hardware (USB) access
        #"/dev/bus/usb"
        #"/dev/input"
        #"/dev/uinput"
      ];
      bind.ro = [
        # host system information
        "/etc/lsb-release"
        "/etc/os-release"
        # system DBUS socket
        "/run/dbus/system_bus_socket"
        # hardware information
        "/sys/bus"
        "/sys/class"
        "/sys/dev"
        "/sys/devices"
        # nix
        ("/etc/nix/nix.conf")
        ("/nix/var")
        # LaTeX
        (sloth.concat' sloth.homeDir "/texmf")
        # browser read-only
        (sloth.mkdir (sloth.concat' sloth.homeDir "/Downloads/read-only"))
        # maybe read-write
        (sloth.concat' sloth.homeDir "/devel")
        (sloth.concat' sloth.homeDir "/git")
        #(sloth.concat' sloth.homeDir "/Documents")
        #(sloth.concat' sloth.homeDir "/Module")
      ];
      bind.rw = [
        # .zhistory
        [
          (sloth.mkdir (appDir name))
          ("${ssd-mnt}${home-dir}")
        ]
        # browser read-write
        (sloth.mkdir (sloth.concat' sloth.homeDir "/Downloads/read-write"))
      ];
    };
  };
}
