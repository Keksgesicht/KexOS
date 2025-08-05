{ ... }:

{
  # https://unix.stackexchange.com/questions/694464/how-to-make-systemd-to-stop-kicking-the-hardware-watchdog
  systemd.settings.Manager = {
    #WatchdogDevice = "/dev/watchdog";
    RebootWatchdogSec  = "3min";
    RuntimeWatchdogSec = "2min";
  };
}
