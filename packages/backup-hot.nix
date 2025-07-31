{ stdenv, lib }:

stdenv.mkDerivation {
  name = "backup-hot";
  src = ../files/packages/backup-hot;

  phases = [ "installPhase" "fixupPhase" ];
  installPhase = ''
    mkdir -p $out/{bin,cfg}
    cp -r $src/bin/. $out/bin/
    cp -r $src/cfg/. $out/cfg/
  '';

  meta = with lib; {
    description = "Copy important data to usb strorage";
    platforms = platforms.all;
  };
}
