{ ... }:

{
  services.autosuspend = {
    enable = true;
    settings = {
      enable = true;
      interval = 60;
      idle_time = 23 * 60;
    };
    # https://autosuspend.readthedocs.io/en/latest/available_checks.html
    checks = {
      # Keep the system active when GUI user is logged in
      LocalUsers = {
        enabled = true;
        class = "LogindSessionsIdle";
        types = "tty,wayland";
        states = "active,online";
        classes = "user";
      };
    };
  };

  /*
   * https://www.freedesktop.org/software/systemd/man/systemd.exec.html#LogFilterPatterns=
   * https://forum.manjaro.org/t/stable-update-2023-06-04-kernels-gnome-44-1-plasma-5-27-5-python-3-11-toolchain-firefox/141610/3
   * do not log messages with the following regex
   */
  systemd.services."autosuspend" = {
    #overrideStrategy = "asDropin";
    serviceConfig.LogFilterPatterns = [
      ''~autosuspend\.Processor - INFO - Starting new check iteration''
    ];
  };
}
