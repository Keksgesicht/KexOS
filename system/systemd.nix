{ config, ... }:

let
  cfgNetName = config.networking.hostName;
in
{
  # desktop / server
  services.journald.extraConfig =
    if (cfgNetName == "cookieclicker") then
      ''
      SystemMaxUse=10G
      SystemKeepFree=16G
      SystemMaxFiles=768
      ''
    else if (cfgNetName == "cookiethinker") then
      ''
      SystemMaxUse=2G
      SystemKeepFree=8G
      SystemMaxFiles=300
      ''
    else if (cfgNetName == "cookiemailer") then
      ''
      SystemMaxUse=512M
      SystemKeepFree=1G
      SystemMaxFiles=50
      ''
    else
      ''
      SystemMaxUse=1G
      SystemKeepFree=4G
      SystemMaxFiles=100
      ''
  ;
}
