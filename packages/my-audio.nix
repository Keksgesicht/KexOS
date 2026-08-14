{ secrets-pkg, pkgs, lib, ... }:

let
  bt-dev-path = "${secrets-pkg}/wireless/bt-dev";
  rf = builtins.readFile;
  rem-suf = (str: lib.removeSuffix "\n" str);
  MY_BT_DEV_IN_EAR        = rem-suf (rf "${bt-dev-path}/in-ears");
  MY_BT_DEV_OVER_THE_EARS = rem-suf (rf "${bt-dev-path}/over-the-ears");
in
{
  KexOS.packages."my-audio" = pkgs.stdenv.mkDerivation {
    name = "my-audio";
    version = "1.0.0";
    src = ../files/packages/my-audio;

    phases = [ "installPhase" "fixupPhase" ];
    installPhase = ''
      mkdir -p $out/{bin,lib,state}
      cp -r $src/bin/.   $out/bin/
      cp -r $src/lib/.   $out/lib/
      cp -r $src/state/. $out/state/

      substituteInPlace $out/lib/settings.sh $out/state/* \
        --replace-quiet '@MY_BT_DEV_IN_EAR@'        '${MY_BT_DEV_IN_EAR}' \
        --replace-quiet '@MY_BT_DEV_OVER_THE_EARS@' '${MY_BT_DEV_OVER_THE_EARS}'
    '';

    meta = with lib; {
      description = "Keksgesicht's audio setup script collection";
      platforms = platforms.all;
    };
  };
}
