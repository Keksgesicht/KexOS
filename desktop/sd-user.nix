{ ... }:

{
  systemd.services = {
    /*
     * https://www.freedesktop.org/software/systemd/man/systemd.exec.html#LogFilterPatterns=
     * https://forum.manjaro.org/t/stable-update-2023-06-04-kernels-gnome-44-1-plasma-5-27-5-python-3-11-toolchain-firefox/141610/3
     * do not log messages with the following regex
     */
    "user@" = {
      overrideStrategy = "asDropin";
      serviceConfig = {
        TimeoutStopSec = 23;
        LogFilterPatterns = [
          # KWin
          ''~kwin_scene_opengl: 0x[0-9]: GL_INVALID_OPERATION in glDrawBuffers\(unsupported buffer GL_BACK_LEFT\)''
          # Gaming
          ''~wine: using kernel write watches, use_kernel_writewatch 1\.''
          ''~ERROR: ld\.so: object 'libgamemodeauto\.so\.0' from LD_PRELOAD cannot be preloaded \(cannot open shared object file\): ignored\.''
        ];
      };
    };

    # faster shutdowns
    "display-manager" = {
      serviceConfig = {
        TimeoutStopSec = 23;
      };
    };
  };
}
