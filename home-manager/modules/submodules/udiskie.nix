{ pkgs, lib, config, ... }:

{
  options.udiskieConfig.enable = lib.mkEnableOption "Enable udiskie";

  config = lib.mkIf config.udiskieConfig.enable {
    services.udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "never";
    };
  };
}
