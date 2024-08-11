{ lib, config, ... }:

{
  options.swap.enable = lib.mkEnableOption "Make a swapfile.";

  config = lib.mkIf config.swap.enable {
    swapDevices = [{
      device = "/swap/swapfile";
      size = 1024 * 8;
    }];
  };
}
