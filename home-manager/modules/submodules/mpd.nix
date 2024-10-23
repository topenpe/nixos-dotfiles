{ lib, config, ... }:

{
  options.mpdConfig.enable = lib.mkEnableOption "Enable MPD configuration";

  config = lib.mkIf config.mpdConfig.enable {
    services = {
      mpd = {
        enable = true;
        dataDir = "${config.home.homeDirectory}/.local/share/mpd";
        musicDirectory = /mnt/nue/music;
        extraConfig = ''
          auto_update "yes"
          auto_update_depth "12"
          restore_paused "yes"
          audio_output {
            type "pipewire"
              name "PipeWire Sound Server"
          }
          audio_output {
            type "fifo"
              name "my_fifo"
              path "/tmp/mpd.fifo"
              format "44100:16:2"
          }
          filesystem_charset "UTF-8"
        '';
      };

      mpdris2 = {
        enable = true;
        multimediaKeys = true;
        notifications = true;
      };
    };
  };
}
