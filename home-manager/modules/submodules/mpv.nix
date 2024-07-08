{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.mpvConfig.enable = lib.mkEnableOption "Enable MPV configuration";

  config = lib.mkIf config.mpvConfig.enable {
    programs.mpv = {
      enable = true;
      config = {
        profile = "main";
        force-window = "true";
      };
    };
  };
}
