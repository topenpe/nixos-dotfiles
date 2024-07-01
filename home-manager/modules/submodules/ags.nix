{ lib, config, inputs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];
  options.widgets.enable = lib.mkEnableOption "Enable AGS widgets";

  config = lib.mkIf config.widgets.enable {
    programs.ags = {
      enable = true;
      configDir = ./ags;
    };
  };
}
