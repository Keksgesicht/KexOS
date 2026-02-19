{ self, config, pkgs, lib, ssd-mnt, home-dir, username, ... }:

let
  hn = config.networking.hostName;
  sddmHome = "/var/lib/sddm";

  dn = "/dev/null";
  sdUser = "/.config/systemd/user";
  icons-path = ".local/share/icons";

  sddmFaces = pkgs.stdenv.mkDerivation {
    name = "sddm-faces";
    src = "${self}/files/face.png";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out
      cp -r $src $out/${username}.face.icon
    '';
  };

  plasma-config = pkgs.callPackage "${self}/packages/config-plasma.nix" {};
  sddm-config = (src-dir: file: src-ext: ''
    C  ${sddmHome}/${file} - - - - ${src-dir}/${file}${src-ext}
    Z  ${sddmHome}/${file} 0644 sddm sddm - -
  '');
in
{
  # Enable the KDE Plasma Desktop Environment (wayland by default).
  services.displayManager = {
    /*
    plasma-login-manager = {
      enable = true;
      settings = {};
    };
    */
    sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
      theme = "breeze";
      settings.Theme = {
        FacesDir = "${sddmFaces}";
        CursorTheme = "LyraG-cursors";
        CursorSize = 36;
      };
    };
    defaultSession = "plasma";
  };

  environment.etc = {
    # setup ~/.config for SDDM
    "tmpfiles.d/ZZ-sddm-00.conf".text = ''
      d  ${sddmHome}/.config          0750 sddm sddm - -
    '';
    # disable bootup sound (laptop)
    "tmpfiles.d/ZZ-sddm-10-no-audio.conf".text = ''
      d  ${sddmHome}/.config/systemd  0750 sddm sddm - -
      d  ${sddmHome}${sdUser}         0750 sddm sddm - -
      L+ ${sddmHome}${sdUser}/pipewire.service       - - - - ${dn}
      L+ ${sddmHome}${sdUser}/pipewire.socket        - - - - ${dn}
      L+ ${sddmHome}${sdUser}/pipewire-pulse.service - - - - ${dn}
      L+ ${sddmHome}${sdUser}/pipewire-pulse.socket  - - - - ${dn}
      L+ ${sddmHome}${sdUser}/wireplumber.service    - - - - ${dn}
    '';
    # add cursor theme
    "tmpfiles.d/ZZ-sddm-20.conf".text = ''
      d  ${sddmHome}/.local        0750 sddm sddm - -
      d  ${sddmHome}/.local/share  0750 sddm sddm - -
      L+ ${sddmHome}/${icons-path} - - - - ${ssd-mnt}${home-dir}/${icons-path}
    '';
  } // lib.optionalAttrs (hn == "cookieclicker") {
    # disable DP over USB-C displays
    "tmpfiles.d/ZZ-sddm-99-user-config.conf".text = ""
    + (sddm-config plasma-config ".config/kwinoutputconfig.json" ".machine-tower")
    + (sddm-config plasma-config ".config/kcminputrc" "")
    ;
  };
}
