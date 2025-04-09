{ ... }:

{
  # https://wiki.archlinux.org/title/sysctl
  # https://man7.org/linux/man-pages/man5/proc.5.html
  boot.kernel.sysctl = {
    # reboot on panic after x seconds
    "kernel.panic" = 42;

    # improve compilation
    # https://man7.org/linux/man-pages/man7/inotify.7.html
    "fs.inotify.max_user_instances" = 1024;
    "fs.inotify.max_user_watches" = 1048576;

    # improve compatibility with Windows games through wine
    # Fedora 39: https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount
    # Ubuntu 24.04: https://www.omgubuntu.co.uk/2024/03/ubuntu-24-04-makes-a-small-tweak-that-dramatically-improves-gaming
    "vm.max_map_count" = 1048576;

    # enable ptrace attach mode for normal processes
    # echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    # NOT recommended
    # use `sudo` when using `-p` with `strace`
    # https://man7.org/linux/man-pages/man2/ptrace.2.html
    #"sys.kernel.yama.ptrace_scope" = 1;
  };
}
