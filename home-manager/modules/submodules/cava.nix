{ lib, config, ... }:

{
  options.kahve.enable = lib.mkEnableOption "Enable cava configuration";

  config = lib.mkIf config.kahve.enable {
    programs.cava = {
      enable = true;
      settings = {
        general = {
          mode = "normal";
          framerate = 60;
          autosens = 1;
          sensitivity = 75;
          bars = 0;
          bar_width = 2;
          bar_spacing = 1;
        };

        input = {
          method = "pipewire";
          source = "auto";
        };

        output = {
          method = "ncurses";
          orientation = "bottom";
          channels = "mono";
          mono_option = "average";
          reverse = 0;
        };

        color = {
          gradient = 1;
          gradient_count = 3;
          gradient_color_1 = "'#${config.colorScheme.palette.base09}'";
          gradient_color_2 = "'#${config.colorScheme.palette.base0B}'";
          gradient_color_3 = "'#${config.colorScheme.palette.base06}'";
        };

        smoothing = {
          monstercat = "2.0";
          waves = 0;
          noise_reduction = 33;
        };

        eq = {
          "1" = "1";
          "2" = "1";
          "3" = "1";
          "4" = "1";
          "5" = "1";
        };
      };
    };
  };
}
