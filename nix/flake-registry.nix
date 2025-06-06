{ inputs, pkgs-stable, pkgs-latest, isDesktop, ... }:

let
  # prevent flake from downloading source on every command execution
  # https://www.reddit.com/r/NixOS/comments/s69oxh/nix_in_flakes_mode_but_without_downloading/
  nix-reg-name = (name: {
    from = { id = name; type = "indirect"; };
  });
  nix-reg-path = (pkgs: np: {
    to = { path = (builtins.toString (pkgs {}).path); type = "path"; };
    flake = np;
  });

  nrp-latest = nix-reg-path pkgs-latest inputs.nixpkgs-unstable;
  nrp-stable = nix-reg-path pkgs-stable inputs.nixpkgs-stable;
in

{
  # flake "paths" to source from with `nix run` or `nix shell`
  nix.registry = {
    self.flake = inputs.self;
    pkgs-stable = (nix-reg-name "pkgs-stable") // nrp-stable;
    pkgs-latest = (nix-reg-name "pkgs-latest") // nrp-latest;
    nixpkgs = (nix-reg-name "nixpkgs") // (
      if isDesktop
      then nrp-latest
      else nrp-stable
    );
  };

  # prevent flake from downloading registry on every command excution
  # https://discourse.nixos.org/t/how-to-prevent-flake-from-downloading-registry-at-every-flake-command/32003/2
  nix.settings.flake-registry = "${inputs.flake-registry}/flake-registry.json";
}
