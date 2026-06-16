{
  lib,
  config,
  ...
}:

{ # I occasionally use additional drives, this is where I declare their mountpoints
  options.mounters.enable = lib.mkEnableOption "Module for managing additional disks";

  config = lib.mkIf config.mounters.enable {
    fileSystems = {
      "/mnt/nezumi" = {
        label = "nezumi";
        fsType = "btrfs";
        options = [ "compress=zstd" ];
      };
#      "/mnt/shinzaburo" = {
#        label = "shinzaburo";
#        options = [ "compress=zstd" ];
#      };
    };
  };
}
