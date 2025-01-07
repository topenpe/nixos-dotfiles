{ lib, config, ... }:

{
  options.mounters.enable = lib.mkEnableOption "Enable filesystems options";

  config = lib.mkIf config.mounters.enable {
    fileSystems = {
      "/".options = [ "compress=zstd" ];
      "/home".options = [ "compress=zstd" ];
      "/nix".options = [
        "compress=zstd"
        "noatime"
      ];

#      "/mnt/nue" = {
#        label = "nue";
#        options = [ "compress=zstd" ];
#      };
    };
  };
}
