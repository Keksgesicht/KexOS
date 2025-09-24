{ ... }:

{
  imports = [
    ./dispatcher.nix
  ];

  networking.networkmanager.enable = true;

  # https://askubuntu.com/questions/1018576/what-does-networkmanager-wait-online-service-do
  systemd.services."NetworkManager-wait-online".enable = false;
}
