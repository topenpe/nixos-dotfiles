{ lib, config, ... }:

{
  options.nhConfig.enable = lib.mkEnableOption "Enable Nix Helper";

  config = lib.mkIf config.nhConfig.enable {
    programs.nh = {
      enable = true;
      osFlake = "$HOME/system/";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 2";
      };
    };
  };
}
