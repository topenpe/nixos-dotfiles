{ lib, config, ... }:

{
  options.mpdConfig.enable = lib.mkEnableOption "Enable MPD configuration";

  config = lib.mkIf config.mpdConfig.enable {
    services = {
      mpd = {
        enable = true;
        dataDir = "${config.home.homeDirectory}/.local/share/mpd";
        #musicDirectory = "${config.home.homeDirectory}/music";
        musicDirectory = "/mnt/nezumi/music/";
      };

      mpdris2 = {
        enable = true;
        multimediaKeys = true;
        notifications = true;
      };
    };
  };
}
