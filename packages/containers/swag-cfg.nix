{ stdenv, lib }:

stdenv.mkDerivation {
  name = "swag-proxy-config";
  src = ../../files/packages/containers/swag;

  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/nginx
    cp -r $src/nginx/. $out/nginx/
  '';

  meta = with lib; {
    description = "Configuration files for frontend proxy";
    platforms = platforms.all;
  };
}
