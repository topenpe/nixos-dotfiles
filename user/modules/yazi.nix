{ lib, config, pkgs, ... }:

{
  options.yaziConfig.enable = lib.mkEnableOption "Enable yazi, terminal-based file manager";

  config = lib.mkIf config.yaziConfig.enable {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
      enableZshIntegration = true;
      extraPackages = with pkgs; [
        ouch
        glow
      ];
    };
  };
}
