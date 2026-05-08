{ pkgs, ... }:

{
  networking.networkmanager.dispatcherScript = {
    "50-public-ipv6".packages = with pkgs; [
      coreutils gawk iproute2 procps util-linux
    ];
  };
}
