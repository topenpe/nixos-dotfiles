{
  lib,
  config,
  inputs,
  ...
}:

{
  imports = [ inputs.ags.homeManagerModules.default ];
  options.agsConfig.enable = lib.mkEnableOption "Enable AGS widgets";

  config = lib.mkIf config.agsConfig.enable {
    programs.ags = {
      enable = true;
      configDir = ./ags;
    };
  };
}
