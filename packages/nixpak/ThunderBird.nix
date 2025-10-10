{ sloth, bindHomeDir, ... }:
{ pkgs, lib, ... }:

let
  name = "ThunderBird";
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = pkgs.thunderbird; binName = "thunderbird"; }
      ];
      time = true;
    };

    dbus.policies = {
      "org.freedesktop.Notifications" = "talk";
      "org.mozilla.thunderbird.*" = "own";
    };

    bubblewrap = {
      bind.ro = [
        [
          # mozilla.cfg
          ("${pkgs.thunderbird}/lib/thunderbird")
          ("/app/etc/thunderbird")
        ]
        "/sys/bus/pci"
      ];
      bind.rw = [
        (bindHomeDir name "/.thunderbird")
        # mail.openpgp.allow_external_gnupg
        # https://superuser.com/questions/1758464/how-do-i-get-thunderbird-to-use-my-gpg-keyring#answer-1795430
        (sloth.concat' sloth.xdgConfigHome "/gnupg")
      ];
      network = true;
    };
  };
}
