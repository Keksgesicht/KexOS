{
  inputs = {
    # prevent flake from downloading registry on every command excution
    flake-registry = {
      url = "github:nixos/flake-registry";
      flake = false;
    };

    # https://github.com/NixOS/nixpkgs
    # update nixpkgs every couple of days
    nixpkgs-stable.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    nixpkgs-custom.url = "/home/keks/git/hdd/nix/nixpkgs/custom";

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
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows      = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };

    # https://nixos.wiki/wiki/Secure_Boot
    # https://github.com/nix-community/lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # https://github.com/nixpak/nixpak
    nixpak = {
      url = "github:Keksgesicht/nixpak/sort-bind-paths";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # https://github.com/pjones/plasma-manager
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    cookie-pkg, secrets-pkg,
    nixpkgs-stable, nixpkgs-unstable, nixpkgs-custom,
    home-manager, impermanence, lanzaboote,
    ...
  }@inputs: {
    nixosConfigurations =
    let
      myArgs = (system: rec {
        inherit inputs;
        inherit system;

        self = inputs.self;

        pkgs-stable = (extraConfig: import inputs.nixpkgs-stable ({
          inherit system;
        } // extraConfig));
        pkgs-latest = (extraConfig: import inputs.nixpkgs-unstable ({
          inherit system;
        } // extraConfig));

        pkgs-fetch = (git: hash: cfg: import (fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/${git}.tar.gz";
          sha256 = "${hash}";
        }) ({ inherit system; } // cfg));

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

        cookie-pkg = inputs.cookie-pkg;
        secrets-dir = "/etc/nixos/secrets";
        secrets-pkg = inputs.secrets-pkg;

        lan-subnet-v4 = "192.168.178";
        lan-subnet-v6 = "fd00:da:b44::192:168:178";
        vpn-subnet-v4 = "192.168.176";
        vpn-subnet-v6 = "fd00:2307:";
        pod-subnet-v4 = "172.23";
        pod-subnet-v6 = "fd00:172:23:";
      });
    in
    {
      # nix build -L .'#'nixosConfigurations."live-cd".config.system.build.isoImage
      "live-cd" = nixpkgs-unstable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = (myArgs system) // {
          isDesktop = true;
          vpn-ip-suf = "1";
          lan-ip-suf = "0";
          lan-subnet-v4 = "0.0.0";
        };
        modules = [
          ./machines/installer
          home-manager.nixosModules.home-manager
        ];
      };
      "usb-stick" = nixpkgs-unstable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = (myArgs system) // {
          isDesktop = true;
          vpn-ip-suf = "1";
          lan-ip-suf = "0";
          lan-subnet-v4 = "0.0.0";
        };
        modules = [
          ./machines/usb-stick.nix
          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
        ];
      };

      # sudo nixos-rebuild --flake . test -L
      "cookieclicker" = nixpkgs-unstable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = (myArgs system) // {
          isDesktop = true;
          lan-ip-suf = "220";
          vpn-ip-suf = "1";
          ifLan = "enp4s0";
          ifWlan = "wlp5s0";
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
          vpn-ip-suf = "102";
          lan-ip-suf = "1";
          ifLan = "enp2s0";
          ifWlan = "wlo1";
        };
        modules = [
          ./machines/cookiethinker.nix
          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
        ];
      };

      # nix build -L .'#'nixosConfigurations."cookiepi".config.system.build.sdImage
      "cookiepi" = nixpkgs-stable.lib.nixosSystem rec {
        system = "aarch64-linux";
        specialArgs = (myArgs system) // {
          vpn-ip-suf = "4";
          lan-ip-suf = "221";
          ifLan = "enu1u1u1";
          ifWlan = "wlan0";
        };
        modules = [
          ./machines/cookiepi.nix
          impermanence.nixosModules.impermanence
        ];
      };
      "cookieflyer" = nixpkgs-stable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = (myArgs system) // {
          lan-subnet-v6 = "fd00:3581::192:168:178";
          lan-ip-suf = "25";
          vpn-ip-suf = "2";
          ifLan = "enp0s31f6";
        };
        modules = [
          ./machines/cookieflyer.nix
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
        ];
      };
      "cookiemailer" = nixpkgs-stable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = (myArgs system) // {
          vpn-ip-suf = "3";
          lan-ip-suf = "1";
        };
        modules = [
          ./machines/cookiemailer.nix
          impermanence.nixosModules.impermanence
        ];
      };

    };
  };
}
