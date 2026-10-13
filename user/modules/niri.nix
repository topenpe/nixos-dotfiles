{ lib, config, ... }:

{
  options.niriConfig.enable = lib.mkEnableOption "Enable the Niri window manager";

  config = lib.mkIf config.niriConfig.enable {
    wayland.windowManager.niri = {
      enable = true;
    };
  };
}
