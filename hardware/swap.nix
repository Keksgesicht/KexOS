{ config, lib, ... }:

let
  inherit (lib) types;

  hn = config.networking.hostName;
in
{
  # random encryption will resetup the LUKS header
  # using by-partuuid should not change between system reboots or kernel updates
  options.encryptedSwapDevices = lib.mkOption {
    type = types.listOf types.path;
    default = [];
  };

  config.swapDevices = lib.lists.forEach config.encryptedSwapDevices (sDev: {
    device = sDev;
    randomEncryption.enable = true;
    options = [ "nofail" ];
  });

  config.encryptedSwapDevices = []
  ++ lib.optionals (hn == "cookieclicker") [
    "/dev/disk/by-partuuid/85439545-b3f4-f742-948f-e3a7190f5fc7"
  ]
  ++ lib.optionals (hn == "cookieflyer") [
    "/dev/disk/by-id/ata-Samsung_SSD_850_EVO_120GB_S21UNXAGA07082H-part2"
  ]
  ++ lib.optionals (hn == "cookiethinker") [
    "/dev/disk/by-id/nvme-KINGSTON_SNVS500G_50026B76856C0884-part2"
  ];
}
