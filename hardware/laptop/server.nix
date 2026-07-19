{ ... }:

{
  # prevent suspend when closing lid
  services.logind.settings.Login = {
    HandleLidSwitch = "lock";
    HandleLidSwitchDocked = "lock";
    HandleLidSwitchExternalPower = "lock";
  };
}
