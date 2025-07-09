{ ... }:

{
  systemd.services = {
    /*
     * https://www.freedesktop.org/software/systemd/man/systemd.exec.html#LogFilterPatterns=
     * https://forum.manjaro.org/t/stable-update-2023-06-04-kernels-gnome-44-1-plasma-5-27-5-python-3-11-toolchain-firefox/141610/3
     * do not log messages with the following regex
     *
     * maybe use `systemd-escape`
     * use double qoutes
     * escape . ( )
     */
    "user@" = {
      overrideStrategy = "asDropin";
      serviceConfig = {
        TimeoutStopSec = 23;
        LogFilterPatterns = [
          # KWin
          ''~kdeconnect\.core: CompositeUploadJob::startListening\(\) - Error opening a port in range 1739 - 1764''
          ''~kwin_scene_opengl: 0x[0-9]: GL_INVALID_OPERATION in glDrawBuffers\(unsupported buffer GL_BACK_LEFT\)''
          # Gaming
          ''~wine: using kernel write watches, use_kernel_writewatch 1\.''
          ''~ATTENTION: default value of option vk_khr_present_wait overridden by environment\.''
          ''~ATTENTION: default value of option vk_xwayland_wait_ready overridden by environment\.''
          ''~ERROR: ld\.so: object 'libgamemodeauto\.so\.0' from LD_PRELOAD cannot be preloaded \(cannot open shared object file\): ignored\.''
          ''~ERROR: ld\.so: object '/home/keks/\.local/share/Steam/ubuntu12_32/gameoverlayrenderer\.so' from LD_PRELOAD cannot be preloaded \(wrong ELF class: ELFCLASS32\): ignored.''
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
