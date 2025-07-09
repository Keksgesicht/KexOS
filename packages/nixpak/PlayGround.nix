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
        (pkgs.writeShellScriptBin "make-persistent" ''
          while [ -n "$1" ]; do
            if ! [ -e "$1" ]; then
              echo "\"$1\" does not exist!"
              continue
            fi
            DIR_TGT="$HOME/.persistence/$1"
            DIR_PAR=$(dirname "$DIR_TGT")
            mkdir -p "$DIR_PAR"
            if [ -e "$DIR_TGT" ]; then
              echo "\"$DIR_TGT\" already exists!"
            else
              mv -v $1 "$DIR_TGT"
            fi
            ln -sv "$DIR_TGT" "$1"
            shift
          done
          exit 0
        '')
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
      ];
      bind.rw = [
        # .zhistory
        [
          (sloth.mkdir (appDir name))
          ("${ssd-mnt}${home-dir}")
        ]
        # home persistence
        [
          (sloth.mkdir (appDir name))
          (sloth.concat' sloth.homeDir "/.persistence")
        ]
        # browser read-write
        (sloth.mkdir (sloth.concat' sloth.homeDir "/Downloads/read-write"))
        # selectable read-write path
        (sloth.env "PWD")
        (sloth.envOr "NIXPAK_PLAYGROUND_PATH_RW" "/a/b/c")
      ];
    };
  };
}
