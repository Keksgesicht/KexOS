{ config, lib, myDomain, ... }:

{
  nix.settings = {
    substituters = []
      ++ lib.optionals (config.networking.hostName != "cookieclicker") [
        "https://nix-serve.cookieclicker.${myDomain}/"
      ]
      ++ lib.optionals (config.networking.hostName != "cookiepi") [
        "https://nix-serve.cookiepi.${myDomain}/"
      ];
    trusted-public-keys = []
      ++ lib.optionals (config.networking.hostName != "cookieclicker") [
        "nix-serve.cookieclicker.${myDomain}:uR9PO+9+vDixa/2TPJ3pox41GtT2lMhq/fwRLAEMH3s="
      ]
      ++ lib.optionals (config.networking.hostName != "cookiepi") [
        "nix-serve.cookiepi.${myDomain}:rRX9WW+JPdk2lsBKDP2JjJHj7ib5Vh111JxSORwZRdU="
      ];
    # nixos-rebuild failed when a previously online substituters goes offline
    # this reenables local building
    fallback = true;
    # and reduces the time before aborting the usage of binary cache servers
    connect-timeout = 3;
    download-attempts = 2;
  };
}
