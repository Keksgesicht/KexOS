args: config:
let
  inherit (args) lan-subnet-v6;
  inherit (args) lan-ip-suf;
  inherit (args) ifLan;

  hn = config.networking.hostName;
in
{
  MY_IPV6_ULU = "${lan-subnet-v6}:${lan-ip-suf}/64";
  MY_IFLINK =
    if (hn == "cookieclicker") then "br-home"
    else ifLan;
  MY_IPV6_SUFFIX =
    if (hn == "cookieclicker") then "da:b44:${lan-ip-suf}:1"
    else if (hn == "cookieflyer") then "da:c54:${lan-ip-suf}:1"
    else "dead:beef:0815:42";
}
