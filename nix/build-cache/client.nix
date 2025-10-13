{ config, lib, myDomain, ... }:

let
  hn = config.networking.hostName;
  hostList = [ {
      name = "cookieclicker"; proto = "https"; port = "443";
      key = "76N6Zdl9lH866USAdQ92DHqVJedsugR4ajp9/UVGhwo=";
    } {
      name = "cookieflyer"; proto = "https"; port = "443";
      key = "+1N9MpQ5IOpVvrdOipmJAe66g4CO12o3Ed4U5g+C/co=";
    } {
      name = "cookiemailer"; proto = "http"; port = "5000";
      key = "OGeVzmNtrB+2y1nogJnuBrV3+G/LUxCQIasya7ake6A=";
    } {
      name = "cookiepi"; proto = "https"; port = "443";
      key = "gg2p72frz2N8Ocf4amLQRDXkfiUgbO0uz/zuhUcwrK0=";
  } ];
  hostName = (name: "nix-serve.${name}.internal.${myDomain}");
  hostFilter = (list: func: (func (builtins.filter (e: (hn != e.name)) list)));
in
{
  nix.settings = {
    substituters = hostFilter hostList (l: lib.lists.forEach l (e:
      "${e.proto}://${hostName e.name}:${e.port}/"
    ));
    trusted-public-keys = hostFilter hostList (l: lib.lists.forEach l (e:
      "${hostName e.name}:${e.key}"
    ));

    # nixos-rebuild failed when a previously online substituters goes offline
    # first fallback to upstream nix cache and then build locally
    fallback = true;
    # and reduces the time before aborting the usage of binary cache servers
    connect-timeout = 3;
    download-attempts = 2;
  };
}
