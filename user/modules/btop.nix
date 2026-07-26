{ lib, config, pkgs, ... }:

{
  options.btopConfig.enable = lib.mkEnableOption "Enable btop++ configuration";

  config = lib.mkIf config.btopConfig.enable {
    programs.btop = {
      enable = true;
      package = with pkgs; (btop.override { rocmSupport = true; });
      settings = {
        color_theme = "matcha-dark-sea";
        vim_keys = true;
        update_ms = 100;
        presets = "cpu:1:default,proc:0:default cpu:0:default,gpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
      };
    };
  };
}
