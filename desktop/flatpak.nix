{ pkgs, lib, ... }:

let
  flatpak-overrides = pkgs.callPackage ../packages/flatpak-overrides.nix {};
in
{
  # add flathub as a flatpak repository
  /*
   * flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   * flatpak update
   */

  # generate flatpak overrides by NixOS config
  systemd.tmpfiles.rules = [
    "L+ /var/lib/flatpak/overrides - - - - ${flatpak-overrides}"
  ];

  systemd.user = {
    services = {
      "cleanup-flatpak-document-access" = {
        path = [ pkgs.flatpak ];
        script = ''
          for id in $(flatpak documents); do
            flatpak document-unexport --doc-id "$id";
          done
          exit 0
        '';
      };
    };
    timers = {
      "cleanup-flatpak-document-access" = {
        wantedBy = [ "timers.target" ];
        after = lib.mkForce [ "home-keks-.local-share-flatpak-db.mount" ];
        timerConfig = {
          OnCalendar = "Sun *-*-* 13:37";
          Persistent = true;
        };
      };
    };
  };
}
