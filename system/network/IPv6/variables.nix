args: config:
let
  inherit (args) lan-subnet-v6;
  inherit (args) ip-suf;
in
{
  MY_IPV6_ULU = "${lan-subnet-v6}:${ip-suf}/64";
  MY_IFLINK =
    if (config.networking.hostName == "cookieclicker") then
      "enp4s0"
    else if (config.networking.hostName == "cookiepi") then
      "enp0s31f6"
    else "eth0";
  MY_IPV6_SUFFIX =
    if (config.networking.hostName == "cookieclicker") then
      "da:b44:${ip-suf}:1"
    else if (config.networking.hostName == "cookiepi") then
      "da:c54:${ip-suf}:1"
    else "dead:beef:0815:42";
}
