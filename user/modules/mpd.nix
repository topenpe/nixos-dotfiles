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
        settings = {
          Library = {
            cover_regex = "^(album|cover).*$";
          };
          Notify = {
            summary = "%artist% - %title%";
            timeout = 5000;
            urgency = 1;
          };
        };
      };
    };
  };
}
