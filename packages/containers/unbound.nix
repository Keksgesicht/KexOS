{ stdenv, lib, cookie-pkg }:

let
  hashFile = "${cookie-pkg}/root-dns-server.hash";
in
stdenv.mkDerivation {
  pname = "container-unbound";
  name = "container-unbound";
  version = "1.0.0";

  src = ../../files/packages/containers/unbound;
  # might replacing that with pkgs.dns-root-data
  dnssrc = builtins.fetchurl {
    url = "https://www.internic.net/domain/named.cache";
    sha256 = if (builtins.pathExists hashFile)
             then lib.strings.removeSuffix "\n" (builtins.readFile hashFile)
             else "";
  };

  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out/scripts
    cp -r $src/. $out/scripts/
    ln -s $dnssrc $out/scripts/root.hints
  '';

  meta = with lib; {
    description = "Unbound setup in container";
    platforms = platforms.all;
  };
}
