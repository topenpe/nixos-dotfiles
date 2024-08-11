{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.gtkConfig.enable = lib.mkEnableOption "Enable GTK settings";

  config = lib.mkIf config.gtkConfig.enable {
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.tela-icon-theme;
        name = "Tela";
      };

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

      theme = {
        name = "adw-gtk3";
        package = pkgs.adw-gtk3;
      };
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    xdg.configFile = {
      "gtk-4.0/gtk.css".text = ''
        @define-color blue_1 ${config.colorScheme.palette.base0D};
        @define-color blue_2 ${config.colorScheme.palette.base0D};
        @define-color blue_3 ${config.colorScheme.palette.base0D};
        @define-color blue_4 ${config.colorScheme.palette.base0D};
        @define-color blue_5 ${config.colorScheme.palette.base0D};
        @define-color green_1 ${config.colorScheme.palette.base0B};
        @define-color green_2 ${config.colorScheme.palette.base0B};
        @define-color green_3 ${config.colorScheme.palette.base0B};
        @define-color green_4 ${config.colorScheme.palette.base0B};
        @define-color green_5 ${config.colorScheme.palette.base0B};
        @define-color yellow_1 ${config.colorScheme.palette.base0A};
        @define-color yellow_2 ${config.colorScheme.palette.base0A};
        @define-color yellow_3 ${config.colorScheme.palette.base0A};
        @define-color yellow_4 ${config.colorScheme.palette.base0A};
        @define-color yellow_5 ${config.colorScheme.palette.base0A};
        @define-color orange_1 ${config.colorScheme.palette.base09};
        @define-color orange_2 ${config.colorScheme.palette.base09};
        @define-color orange_3 ${config.colorScheme.palette.base09};
        @define-color orange_4 ${config.colorScheme.palette.base09};
        @define-color orange_5 ${config.colorScheme.palette.base09};
        @define-color red_1 ${config.colorScheme.palette.base08};
        @define-color red_2 ${config.colorScheme.palette.base08};
        @define-color red_3 ${config.colorScheme.palette.base08};
        @define-color red_4 ${config.colorScheme.palette.base08};
        @define-color red_5 ${config.colorScheme.palette.base08};
        @define-color purple_1 ${config.colorScheme.palette.base0E};
        @define-color purple_2 ${config.colorScheme.palette.base0E};
        @define-color purple_3 ${config.colorScheme.palette.base0E};
        @define-color purple_4 ${config.colorScheme.palette.base0E};
        @define-color purple_5 ${config.colorScheme.palette.base0E};
        @define-color brown_1 ${config.colorScheme.palette.base06};
        @define-color brown_2 ${config.colorScheme.palette.base06};
        @define-color brown_3 ${config.colorScheme.palette.base06};
        @define-color brown_4 ${config.colorScheme.palette.base06};
        @define-color brown_5 ${config.colorScheme.palette.base06};
        @define-color light_1 ${config.colorScheme.palette.base02};
        @define-color light_2 ${config.colorScheme.palette.base03};
        @define-color light_3 ${config.colorScheme.palette.base04};
        @define-color light_4 ${config.colorScheme.palette.base02};
        @define-color light_5 ${config.colorScheme.palette.base03};
        @define-color dark_1 mix(${config.colorScheme.palette.base01},${config.colorScheme.palette.base06},0.5);
        @define-color dark_2 mix(${config.colorScheme.palette.base01},${config.colorScheme.palette.base06},0.2);
        @define-color dark_3 ${config.colorScheme.palette.base01};
        @define-color dark_4 mix(${config.colorScheme.palette.base01},black,0.2);
        @define-color dark_5 mix(${config.colorScheme.palette.base01},black,0.4);
        @define-color accent_bg_color @blue;
        @define-color accent_fg_color ${config.colorScheme.palette.base06};
        @define-color accent_color @blue;
        @define-color destructive_bg_color @red;
        @define-color destructive_fg_color ${config.colorScheme.palette.base06};
        @define-color destructive_color @red_4;
        @define-color success_bg_color @green_4;
        @define-color success_fg_color ${config.colorScheme.palette.base06};
        @define-color success_color #1b8553;
        @define-color warning_bg_color @yellow_5;
        @define-color warning_fg_color rgba(0, 0, 0, 0.8);
        @define-color warning_color #9c6e03;
        @define-color error_bg_color @red_3;
        @define-color error_fg_color ${config.colorScheme.palette.base06};
        @define-color error_color @red_4;
        @define-color window_bg_color #fafafa;
        @define-color window_fg_color rgba(0, 0, 0, 0.8);
        @define-color view_bg_color #ffffff;
        @define-color view_fg_color rgba(0, 0, 0, 0.8);
        @define-color headerbar_bg_color #ffffff;
        @define-color headerbar_fg_color rgba(0, 0, 0, 0.8);
        @define-color headerbar_border_color rgba(0, 0, 0, 0.8);
        @define-color headerbar_backdrop_color @window_bg_color;
        @define-color headerbar_shade_color rgba(0, 0, 0, 0.12);
        @define-color headerbar_darker_shade_color rgba(0, 0, 0, 0.12);
        @define-color sidebar_bg_color #ebebeb;
        @define-color sidebar_fg_color rgba(0, 0, 0, 0.8);
        @define-color sidebar_backdrop_color #f2f2f2;
        @define-color sidebar_shade_color rgba(0, 0, 0, 0.07);
        @define-color sidebar_border_color rgba(0, 0, 0, 0.07);
        @define-color secondary_sidebar_bg_color #f3f3f3;
        @define-color secondary_sidebar_fg_color rgba(0, 0, 0, 0.8);
        @define-color secondary_sidebar_backdrop_color #f6f6f6;
        @define-color secondary_sidebar_shade_color rgba(0, 0, 0, 0.07);
        @define-color secondary_sidebar_border_color rgba(0, 0, 0, 0.07);
        @define-color card_bg_color #ffffff;
        @define-color card_fg_color rgba(0, 0, 0, 0.8);
        @define-color card_shade_color rgba(0, 0, 0, 0.07);
        @define-color dialog_bg_color #fafafa;
        @define-color dialog_fg_color rgba(0, 0, 0, 0.8);
        @define-color popover_bg_color #ffffff;
        @define-color popover_fg_color rgba(0, 0, 0, 0.8);
        @define-color popover_shade_color rgba(0, 0, 0, 0.07);
        @define-color thumbnail_bg_color #ffffff;
        @define-color thumbnail_fg_color rgba(0, 0, 0, 0.8);
        @define-color shade_color rgba(0, 0, 0, 0.07);
        @define-color scrollbar_outline_color ${config.colorScheme.palette.base06}
      '';
      "gtk-4.0/gtk-dark.css".text = "${config.xdg.configFile."gtk-4.0/gtk.css".text}";
    };
  };
}
