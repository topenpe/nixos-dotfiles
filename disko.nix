{
  disko.devices = {
    disk = {
      anby = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "2048M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              name = "root";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];

                subvolumes = {

                  "@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };

                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };

                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };

                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };

                  "@swap" = {
                    mountpoint = "/swap";
                    mountOptions = [
                      "noatime"
                      "nodatacow"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];
}
