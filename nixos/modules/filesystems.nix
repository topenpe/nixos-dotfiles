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

      "/mnt/hanabi" = {
        device = "/dev/disk/by-uuid/53ca663a-7c60-4938-a7ae-db3079e6e691";
        fsType = "btrfs";
        options = [ "compress=zstd" ];
      };

      "/mnt/nue" = {
        device = "dev/disk/by-uuid/7db0d695-448c-4a7a-93a8-9a5f53f27a92";
	fsType = "btrfs";
	options = [ "compress=zstd" ];
      };
    };
  };
}
