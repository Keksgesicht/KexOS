{ config, lib, myDomain, ... }:

let
  hn = config.networking.hostName;
  hostList = [ {
      name = "cookieclicker"; proto = "https"; port = "443";
      key = "uR9PO+9+vDixa/2TPJ3pox41GtT2lMhq/fwRLAEMH3s=";
    } {
      name = "cookiemailer"; proto = "http"; port = "5000";
      key = "yElGHv9tU/d6Ef4TDWQymF8q797+LLZd6MmIKjQCaI8=";
    } {
      name = "cookieflyer"; proto = "https"; port = "443";
      key = "goE1zTBxklLmVNYqDBunJ0gyDt1Nwi2CFtn0cfEq03g=";
  } ];
  hostFilter = (list: func: (func (builtins.filter (e: (hn != e.name)) list)));
in
{
  nix.settings = {
    substituters = hostFilter hostList (l: lib.lists.forEach l (e:
      "${e.proto}://nix-serve.${e.name}.${myDomain}:${e.port}/"
    ));
    trusted-public-keys = hostFilter hostList (l: lib.lists.forEach l (e:
      "nix-serve.${e.name}.${myDomain}:${e.key}"
    ));

    # nixos-rebuild failed when a previously online substituters goes offline
    # first fallback to upstream nix cache and then build locally
    fallback = true;
    # and reduces the time before aborting the usage of binary cache servers
    connect-timeout = 3;
    download-attempts = 2;
  };
}
