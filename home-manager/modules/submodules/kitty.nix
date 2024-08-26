{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.kittyConfig.enable = lib.mkEnableOption "Enable kitty";

  config = lib.mkIf config.kittyConfig.enable {
    programs.kitty = {
      enable = true;

      font = {
        package = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
	name = "Iosevka Nerd Font";
	size = 11;
      };

      keybindings = {
	      "alt+a" = "scroll_to_prompt -1";
	      "alt+e" = "scroll_to_prompt 1";
	      "alt+tab" = "next_tab";
	      "ctrl+alt+tab" = "previous_tab";
      };

      settings = {
	      scrollbaclk_lines = 10000;
	      enable_audio_bell = "no";
	      tab_bar_min_tabs = 1;
	      tab_bar_edge = "bottom";
	      tab_bar_style = "powerline";
	      tab_powerline_style = "slanted";
	      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

	      foreground = "#${config.colorScheme.palette.base05}";
	      background = "#${config.colorScheme.palette.base00}";
	      selection_foreground = "#${config.colorScheme.palette.base00}";
	      selection_background = "#${config.colorScheme.palette.base06}";

	      background_opacity = "0.75";

	      cursor = "#${config.colorScheme.palette.base06}";
	      cursor_text_color = "#${config.colorScheme.palette.base00}";

	      url_color = "#${config.colorScheme.palette.base06}";

	      active_border_color = "#${config.colorScheme.palette.base07}";
	      inactive_border_color = "#${config.colorScheme.palette.base04}";
	      bell_border_color = "#${config.colorScheme.palette.base0A}";

	      wayland_titlebar_color = "system";

	      enabled_layouts = "tall";

	      active_tab_foreground = "#${config.colorScheme.palette.base00}";
	      active_tab_background = "#${config.colorScheme.palette.base0E}";
	      inactive_tab_foreground = "#${config.colorScheme.palette.base05}";
	      inactive_tab_background = "#${config.colorScheme.palette.base01}";

	      mark1_foreground = "#${config.colorScheme.palette.base00}";
	      mark1_background = "#${config.colorScheme.palette.base07}";
	      mark2_foreground = "#${config.colorScheme.palette.base00}";
	      mark2_background = "#${config.colorScheme.palette.base0E}";
	      mark3_foreground = "#${config.colorScheme.palette.base00}";
	      mark3_background = "#${config.colorScheme.palette.base0C}";

	      color0 = "#${config.colorScheme.palette.base00}";
	      color8 = "#${config.colorScheme.palette.base00}";

	      color1 = "#${config.colorScheme.palette.base08}";
	      color9 = "#${config.colorScheme.palette.base08}";

	      color2 = "#${config.colorScheme.palette.base0B}";
	      color10 = "#${config.colorScheme.palette.base0B}";

	      color3 = "#${config.colorScheme.palette.base0A}";
	      color11 = "#${config.colorScheme.palette.base0A}";

	      color4 = "#${config.colorScheme.palette.base0D}";
	      color12 = "#${config.colorScheme.palette.base0D}";

	      color5 = "#${config.colorScheme.palette.base0E}";
	      color13 = "#${config.colorScheme.palette.base0E}";

	      color6 = "#${config.colorScheme.palette.base0C}";
	      color14 = "#${config.colorScheme.palette.base0C}";

	      color7 = "#${config.colorScheme.palette.base05}";
	      color15 = "#${config.colorScheme.palette.base05}";
      };
    };
  };
}
