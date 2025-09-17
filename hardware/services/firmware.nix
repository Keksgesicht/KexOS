{ ... }:

# https://nixos.wiki/wiki/Fwupd
{
  # firmware update
  services.fwupd = {
    enable = true;
    #extraRemotes = [];
    #EspLocation = /boot;
  };
}
