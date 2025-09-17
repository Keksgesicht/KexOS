{ pkgs, ... }:

let
  options = [ "NOPASSWD" ];
in
{
  security.sudo = {
    enable = true;
    #package = pkgs.doas;
    execWheelOnly = true;
    extraRules = [ {
      groups = [ "wheel" ];
      commands = [ {
          command = "${pkgs.systemd}/bin/poweroff";
          inherit options;
        } {
          command = "${pkgs.systemd}/bin/reboot";
          inherit options;
        } {
          command = "${pkgs.systemd}/bin/systemctl poweroff";
          inherit options;
        } {
          command = "${pkgs.systemd}/bin/systemctl reboot";
          inherit options;
        } {
          command = "${pkgs.systemd}/bin/systemctl suspend";
          inherit options;
      } ];
    } ];
  };

  environment.shellAliases = {
    poweroff  = "${pkgs.systemd}/bin/poweroff";
    reboot    = "${pkgs.systemd}/bin/reboot";
    systemctl = "${pkgs.systemd}/bin/systemctl";
  };
}
