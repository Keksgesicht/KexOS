{ ... }:

{
  # https://nixos.wiki/wiki/Binary_Cache
  services.nix-serve = {
    enable = true;
    bindAddress = "127.0.0.1";
    port = 5000;
    openFirewall = false;
    secretKeyFile = "/etc/nix-serve/secret-key.pem";
  };

  # mkdir -p /etc/nix-serve
  # nix-store --generate-binary-cache-key nix-serve.<hostname>.${myDomain} \
  #   /etc/nix-serve/secret-key.pem /etc/nix-serve/public-key.pem
  # chmod 600 /etc/nix-serve/secret-key.pem
}
