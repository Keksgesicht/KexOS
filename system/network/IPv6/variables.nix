args: config:
let
  inherit (args) lan-subnet-v6;
  inherit (args) ip-suf;

  hn = config.networking.hostName;
in
{
  MY_IPV6_ULU = "${lan-subnet-v6}:${ip-suf}/64";
  MY_IFLINK =
    if (hn == "cookieclicker") then "enp4s0"
    else if (hn == "cookieflyer") then "enp0s31f6"
    else "eth0";
  MY_IPV6_SUFFIX =
    if (hn == "cookieclicker") then "da:b44:${ip-suf}:1"
    else if (hn == "cookieflyer") then "da:c54:${ip-suf}:1"
    else "dead:beef:0815:42";
}
