{ lib, config, ... }:

{
  options.eww.enable = lib.mkEnableOption "Enable Elkowar's Wacky Widgets";

  config = lib.mkIf config.eww.enable {
    programs.eww = {
      enable = true;
      configDir = ./eww;
    };
  };
}
