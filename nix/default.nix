{ ... }:

{
  imports = [
    ./auto-update.nix
    ./basic.nix
    ./flake-registry.nix
    ./garbage-collect.nix
    ./KexOS.nix
    ./tmp.nix
  ];
}
