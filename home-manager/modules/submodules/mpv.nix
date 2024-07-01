{ pkgs, lib, config, ... }:

{
  options.mpvConfig.enable = lib.mkEnableOption "Enable MPV configuration";

  config = lib.mkIf config.mpvConfig.enable {
    programs.mpv = {
      enable = true;
      config = {
        profile = "main";
        force-window = "true";
        script-opts = "ytdl_hook-ytdl_path=#PATH";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}
