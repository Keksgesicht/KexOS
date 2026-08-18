{ lib, system, ... }:

{
  imports = []
  ++ lib.optionals (system == "aarch64-linux") [
    ../aarch64/binfmt.nix
  ]
  ++ lib.optionals (system == "x86_64-linux") [
    ../x86_64/binfmt.nix
  ];
}
