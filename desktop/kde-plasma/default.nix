# https://nixos.wiki/wiki/KDE
{ config, pkgs, lib, inputs, username, ...}:

let
  libKDE = pkgs.kdePackages;
  plasma = "plasma6";
  qt-ver = "6";

  my-functions = (import ../../nix/my-functions.nix lib);
in
with my-functions;
{
  imports = [
    ../../development/language-server-wrapper.nix
    ./login-manager.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment (wayland by default).
  services.desktopManager."${plasma}".enable = true;

  # I do not need this from nix packages
  environment."${plasma}".excludePackages = with libKDE; [
    elisa
    kate
    khelpcenter
    kmailtransport
    okular
    oxygen
    plasma-browser-integration
    spectacle
  ];

  KexOS.lsp-wrapper.ide-pkgs = [ {
    package = libKDE.kate;
    binName = "kate";
  } ];

  users.users."${username}".packages = [
    config.programs.kdeconnect.package
  ] ++ (with libKDE; [
    discover
    kruler
    # use digital clock with PIM plugin
    akonadi-calendar
    merkuro
    # security stuff
    ksshaskpass
    # enable extract text in KDE's screenshotting tool
    (spectacle.override { tesseractLanguages = [ "deu" "eng" "equ" "osd" ]; })
  ]) ++ (with pkgs; [
    candy-icons
    # graphics info
    clinfo
    mesa-demos
    vulkan-tools
    wayland-utils
  ]);

  systemd.tmpfiles.rules = [
    # calendar does not show events without it
    # https://github.com/NixOS/nixpkgs/issues/143272
    # https://bugs.kde.org/show_bug.cgi?id=400451
    # https://invent.kde.org/plasma/plasma-workspace/-/blob/4df78f841cc16a61d862b5b183e773e9f66436b8/ktimezoned/ktimezoned.cpp#L124
    "L+ /usr/share/zoneinfo  - - - - ${pkgs.tzdata}/share/zoneinfo"
  ];

  systemd.user.services = {
    # calendar of digital clock widget is not configureable without it
    # fix showing duplicate events in calendar widget of plasma panel
    "plasma-plasmashell" =
    let
      kdepim-addons = libKDE.kdepim-addons;
      kdepim-qml-path = "${kdepim-addons}/lib/qt-${qt-ver}/qml";
      kdepim-plugins-path = "${kdepim-addons}/lib/qt-${qt-ver}/plugins";
    in
    {
      overrideStrategy = "asDropin";
      serviceConfig.TimeoutStopSec = 23; # faster restarts when panel bugs out
      environment = {
        # prevent defaults
        PATH = lib.mkForce null;
        TZDIR = lib.mkForce null;
        LOCALE_ARCHIVE = lib.mkForce null;
        # calendar of digital clock widget is not configureable without it
        # fix showing duplicate events in calendar widget of plasma panel
        QT_PLUGIN_PATH = "${kdepim-plugins-path}";
        NIXPKGS_QT6_QML_IMPORT_PATH = "${kdepim-qml-path}";
      };
    };
    "plasma-ksplash" = {
      overrideStrategy = "asDropin";
      serviceConfig.TimeoutStartSec = 15;
    };
  };

  home-manager.users."${username}" =
  let
    plasma-manager = inputs.plasma-manager;
  in
  {
    imports = [
      plasma-manager.homeModules.plasma-manager
      # nix run github:pjones/plasma-manager
    ];

    # luckily home-manager runs after systemd tmpfiles on boot
    programs.plasma.enable = true;
    programs.plasma.configFile =
    if (config.networking.hostName == "cookiethinker") then
    {
      "akonadi_davgroupware_resource_0rc"."General"."refreshInterval".value = "15";
      "kcminputrc"."Keyboard"."NumLock".value    = 1;
      "kscreenlockerrc"."Daemon"."Timeout".value = 3;
      "kwinrulesrc"."General"."count".value      = 3;
      "kwinrulesrc"."General"."rules".value      = "6,8,9";
    }
    else if (config.networking.hostName == "cookieclicker") then
    {
      # power off desktop on button press
      "powerdevilrc"."AC/SuspendAndShutdown"."PowerButtonAction".value = 8;
      "powerdevilrc"."Battery/SuspendAndShutdown"."PowerButtonAction".value = 8;
      # UPS will drain much faster
      "powerdevilrc"."BatteryManagement"."BatteryLowLevel".value = 42;
      "powerdevilrc"."BatteryManagement"."BatteryCriticalLevel".value = 32;
    }
    else {};
  };
}
