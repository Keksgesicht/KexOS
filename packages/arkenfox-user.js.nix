{ lib, stdenv, fetchFromGitHub, patchSet ? "" }:

let
  pkgver  = "v135";
  commit  = "3d76c74c80485931425464fec0e59d6cb461677a";
  nixhash = "sha256-21DoV4SMueMFRHMsvfsPfQIOtsvRWNY06rE4gB7xFnc=";

  patchDir = ../files/packages/arkenfox-user.js;
  jsFile = "user.js";
in
stdenv.mkDerivation {
  pname = "arkenfox-user.js";
  name = "arkenfox user.js";
  version = pkgver;

  # https://github.com/arkenfox/user.js
  src = fetchFromGitHub {
    owner = "arkenfox";
    repo = "user.js";
    rev = commit;
    sha256 = nixhash;
  };

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];
  buildPhase = ''
    cp $src/${jsFile} ./
    # force keywords (adresses in urlbar only)
    sed -i '/"keyword.enabled"/s|//||' ${jsFile}
  ''
  + lib.strings.optionalString (patchSet == "FireFox") ''
    # page width and height
    sed -i '/"privacy.resistFingerprinting.letterboxing"/s|true|false|' ${jsFile}
    # shutdown clear history
    sed -i '/"browser.startup.page"/s|, .*);|, 3);|' ${jsFile}
    sed -i '/"privacy.clearOnShutdown.history"/s|true|false|' ${jsFile}
    # chrome userContent.css (Moodle)
    cat ${patchDir}/chrome-userContent.css.patch >> ${jsFile}
  ''
  + lib.strings.optionalString (patchSet == "LibreWolf") ''
    # startup page
    sed -i '/"browser.startup.page"/s|, .*);|, 1);|' ${jsFile}
    # audio volume
    cat ${patchDir}/audio-volume.patch >> ${jsFile}
  '';
  installPhase = ''
    mkdir -p $out
    cp ${jsFile} $out/
  '';

  meta = with lib; {
    description = "Arkenfox user.js with custom patches";
    platforms = platforms.all;
  };
}
