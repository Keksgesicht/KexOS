{
  inputs = {
    # https://github.com/NixOS/nixpkgs
    # update nixpkgs every couple of days
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # system state
    cookie-pkg = {
      url = "/etc/unCookie";
      flake = false;
    };

    # my semi-problematic data
    secrets-pkg = {
      url = "/etc/nixos/secrets/local";
      flake = false;
    };

    # https://nixos.wiki/wiki/Home_Manager
    # https://github.com/nix-community/home-manager
    # https://nix-community.github.io/home-manager/
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # https://nixos.wiki/wiki/Impermanence
    # https://github.com/nix-community/impermanence
    impermanence = {
      type = "github";
      owner = "nix-community";
      repo = "impermanence";
      ref = "master";
      rev = "a33ef102a02ce77d3e39c25197664b7a636f9c30";
    };

    # https://nixos.wiki/wiki/Secure_Boot
    # https://github.com/nix-community/lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # https://github.com/nixpak/nixpak
    nixpak = {
      type = "github";
      owner = "nixpak";
      repo = "nixpak";
      ref = "master";
      rev = "b0862a125da8fe5d179633d6cc7aed57d5316871";

      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # https://github.com/pjones/plasma-manager
    plasma-manager = {
      type = "github";
      owner = "pjones";
      repo = "plasma-manager";
      ref = "trunk";
      rev = "96a90a7f5ce6b29e01d7da83d082e870e4462174";

      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs-stable,
    nixpkgs-unstable,
    cookie-pkg,
    secrets-pkg,
    home-manager,
    impermanence,
    lanzaboote,
    nixpak,
    plasma-manager,
  }@inputs: {
    nixosConfigurations =
    let
      myArgs = (system: rec {
        inherit inputs;
        inherit system;

        pkgs-stable = (extraConfig: import inputs.nixpkgs-stable ({
          inherit system;
        } // extraConfig));
        pkgs-latest = (extraConfig: import inputs.nixpkgs-unstable ({
          inherit system;
        } // extraConfig));

        isDesktop = false;
        holidayMode = false;

        username = "keks";
        home-dir = "/home/${username}";
        myDomain = "keksgesicht.de";

        ssd-name = "main";
        ssd-mnt  = "/mnt/${ssd-name}";
        hdd-name = "array";
        hdd-mnt  = "/mnt/${hdd-name}";
        nvm-name = "ram";
        nvm-mnt  = "/mnt/${nvm-name}";
        data-dir = "${hdd-mnt}/homeBraunJan";

        secrets-dir = "/etc/nixos/secrets";
        secrets-pkg = inputs.secrets-pkg;
        cookie-pkg  = inputs.cookie-pkg;
        self = inputs.self;

        lan-subnet-v4 = "192.168.178";
        lan-subnet-v6 = "fd00:da:b44::192:168:178";
        vpn-subnet-v4 = "192.168.176";
        vpn-subnet-v6 = "fd00:2307:";
        pod-subnet-v4 = "172.23";
        pod-subnet-v6 = "fd00:172:23:";
      });
    in
    {
      # nix build -L .#nixosConfigurations."live-cd".config.system.build.toplevel
      "live-cd" = nixpkgs-stable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = myArgs system;
        modules = [
          ./machines/installer
          home-manager.nixosModules.home-manager
        ];
      };
      "live-cd-graphics" = nixpkgs-unstable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = (myArgs system) // {
          isDesktop = true;
        };
        modules = [
          ./machines/installer
          ./machines/installer/graphics.nix
          home-manager.nixosModules.home-manager
        ];
      };

      # sudo nixos-rebuild --flake . test -L
      "cookieclicker" = nixpkgs-unstable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = (myArgs system) // {
          isDesktop = true;
          ip-suf = "220";
        };
        modules = [
          ./machines/cookieclicker.nix
          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
        ];
      };

      "cookiethinker" = nixpkgs-unstable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = (myArgs system) // {
          isDesktop = true;
        };
        modules = [
          ./machines/cookiethinker.nix
          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
        ];
      };

      "cookieflyer" = nixpkgs-stable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = (myArgs system) // {
          lan-subnet-v6 = "fd00:da:c54::192:168:178";
          ip-suf = "25";
        };
        modules = [
          ./machines/cookieflyer.nix
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
        ];
      };

      "cookiemailer" = nixpkgs-stable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = myArgs system;
        modules = [
          ./machines/cookiemailer.nix
          impermanence.nixosModules.impermanence
        ];
      };

    };
  };
}
