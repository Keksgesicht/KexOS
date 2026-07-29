{ bindHomeDir, ... }:
{ pkgs-stable, pkgs-latest, ... }:

let
  name = "Chromium";
  pkgs = pkgs-stable {};

  # otherwise, chromium aggressivly tries to open KDE Wallet
  args-wallet = "--password-store=basic";

  # no hardware acceleration without it
  # https://github.com/NixOS/nixpkgs/issues/249152
  args-vulkan = "--enable-features=" + (builtins.concatStringsSep "," [
    "VaapiVideoDecoder" "VaapiIgnoreDriverChecks"
    "Vulkan" "DefaultANGLEVulkan" "VulkanFromANGLE"
  ]);
in
{
  nixpak."${name}" = {
    wrapper = {
      packages = [
        { package = pkgs.brave; binName = "brave"; appFile = [
          { src = "brave-browser"; args.extra = [ args-wallet args-vulkan ]; }
        ]; }
        { package = pkgs.ungoogled-chromium; binName = "chromium"; appFile = [
          { src = "chromium-browser"; args.extra = [ args-wallet ]; }
        ]; }
      ];
      variables = {
        # no hardware acceleration without it
        VK_ADD_DRIVER_FILES = builtins.concatStringsSep "/" [
          "/run/opengl-driver/share/vulkan/icd.d"
          "radeon_icd.x86_64.json"
        ];
      };
      chromiumCleanupScript = true;
      audio = true;
      time = true;
    };

    dbus.policies = {
      "org.mpris.MediaPlayer2.brave.*" = "own";
      "org.mpris.MediaPlayer2.chromium.*" = "own";
    };

    gpu.enable = true;

    bubblewrap = {
      bind.rw = [
        (bindHomeDir name "/.config/BraveSoftware")
        (bindHomeDir name "/.config/chromium")
      ];
      network = true;
      sockets.x11 = true;
    };
  };
}
