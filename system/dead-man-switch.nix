{ pkgs, vpn-subnet-v4, ... }:

let
  intval = "5";
  count = "3";
  dms-dir = "/tmp/network-isolation-recovery";
  dms-file = "${dms-dir}/my-dms.txt";
in
{
  # recover from broken network setup
  systemd.services."network-isolation-recovery" = {
    path = with pkgs; [ coreutils gnugrep iputils systemd ];
    script = ''
      reset-value() {
        echo 0 > ${dms-file}
        exit 0
      }
      mkdir -p "${dms-dir}"
      touch ${dms-file}
      dms=$(cat ${dms-file})
      if ! echo "$dms" | grep -qE '^[0-9]+$'; then
        reset-value
      fi
      ping -c1 -W1 ${vpn-subnet-v4}.3 >/dev/null && reset-value
      sleep 2s
      ping -c1 -W1 ${vpn-subnet-v4}.3 >/dev/null && reset-value
      sleep 3s
      ping -c1 -W1 ${vpn-subnet-v4}.3 >/dev/null && reset-value
      dms=$(( dms + 1 ))
      if [ "${count}" -le "$dms" ]; then
        systemctl --no-block reboot
      fi
      echo "$dms" > ${dms-file}
      exit 0
    '';
    startAt = "*-*-* *:00/${intval}:00";
  };
}
