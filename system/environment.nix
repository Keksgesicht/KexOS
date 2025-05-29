{ ...}:

let
  lc_deu = "de_DE.UTF-8";
  lc_eng = "en_US.UTF-8";
in
{
  time.timeZone = "Europe/Berlin";

  # https://nixos.wiki/wiki/Locales
  i18n = {
    defaultLocale = lc_eng;
    extraLocaleSettings = {
      LANGUAGE   = "en_US:en:C";
      LC_COLLATE = lc_eng;
      LC_CTYPE   = lc_eng;
      LC_ADDRESS        = lc_deu;
      LC_IDENTIFICATION = lc_deu;
      LC_MEASUREMENT    = lc_deu;
      LC_MONETARY       = lc_deu;
      LC_MESSAGES       = lc_eng;
      LC_NAME           = lc_deu;
      LC_NUMERIC        = lc_deu;
      LC_PAPER          = lc_deu;
      LC_TELEPHONE      = lc_deu;
      LC_TIME           = lc_deu;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    model = "pc104";
    layout = "altgr-weur";
    variant = "altgr-weur";
    options = "compose:menu,caps:none"; # disable caps-lock key
    extraLayouts."altgr-weur" = {
      description = "English (Western European AltGr dead keys)";
      # US-Layout with typical European characters on AltGr combinations
      # file has been downloaded from https://altgr-weur.eu/
      symbolsFile = ../files/linux-root/etc/X11/xkb/symbols/altgr-weur;
      languages = [
        "dan" "deu" "eng" "fin" "fra" "ita" "nld" "nor" "por" "spa" "swe"
      ];
    };
  };
}
