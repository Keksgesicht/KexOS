{ pkgs, ... }:

# https://lix.systems/add-to-config/
let
  lixPkgs = pkgs.lixPackageSets.stable;
  lix = lixPkgs.lix;
in
{
  nix.package = lix;

  nixpkgs.overlays = [ (final: prev: {
    inherit (final.lixPackageSets.stable)
      nixpkgs-review
      nix-direnv
      nix-eval-jobs
      nix-fast-build
      colmena
      ;

    nil = prev.nil.override { nix = lix; };
  }) ];

  services.nix-serve.package = lixPkgs.nix-serve-ng;
}
