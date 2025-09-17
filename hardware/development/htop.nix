{ pkgs, ... }:

{
  environment = {
    etc."htoprc".source = ../../files/linux-root/etc/htoprc;
    systemPackages = [
      pkgs.htop
    ];
  };
}
