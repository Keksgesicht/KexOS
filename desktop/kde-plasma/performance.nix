{ config, ... }:

let
  hn = config.networking.hostName;
  maxMem = if (hn == "cookieclicker") then "30"
      else if (hn == "cookiethinker") then "10"
      else "4";
  maxSwap = if (hn == "cookieclicker") then "100"
       else if (hn == "cookiethinker") then  "12"
       else "4";
in
{
  systemd.user.slices = {
    "session".sliceConfig = {
      MemorySwapMax = "0M";
      MemoryMin = "4G";
      MemoryLow = "2G";
      CPUWeight =  200;
      IOWeight  =  200;
    };
    "background".sliceConfig = {
      MemoryMin = "512M";
      MemoryLow = "128M";
      CPUWeight =     80;
      IOWeight  =     80;
    };
    "app".sliceConfig = {
      CPUWeight     =    100;
      IOWeight      =    100;
    };
    "DevShell".sliceConfig = {
      MemorySwapMax = "${maxSwap}G";
      MemoryMax     =  "${maxMem}G";
      MemoryHigh    =  "${maxMem}G";
      CPUWeight     =   100;
      IOWeight      =    95;
    };
  };
}
