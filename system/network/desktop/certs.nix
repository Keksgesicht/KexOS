{ pkgs, lib, ... }:

let
  my-functions = (import ../../../nix/my-functions.nix lib);
in
with my-functions;
{
  # symlinks for all certificates
  environment.etc =
  let
    cert-dir = "ssl/certs";
    cacert-dir = "${pkgs.cacert.unbundled}/etc/${cert-dir}";
    cert-set = builtins.listToAttrs
    ( map
      ( e:
        let
          eCert = lib.removePrefix "${cacert-dir}/" e;
          certName = builtins.head (builtins.split ":" eCert) + ".crt";
        in
        {
          name = "${cert-dir}/unbundled/${certName}";
          value = {
            source = e;
          };
        }
      )
      (listFilesRec cacert-dir)
    );
  in
  cert-set // {
    "ssl/certs/cacert-unbundled".source = cacert-dir;
  };
}
