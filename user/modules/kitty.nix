{ lib, config, pkgs, ... }:

{
  options.kittyConfig.enable = lib.mkEnableOption "Enable kitty the terminal emulator";

  config = lib.mkIf config.kittyConfig.enable {
    programs.kitty = {
      enable = true;
      font = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font";
        size = 14;
      };

      keybindings = {
	      "alt+a" = "scroll_to_prompt -1";
	      "alt+e" = "scroll_to_prompt 1";
	      "alt+tab" = "next_tab";
	      "ctrl+alt+tab" = "previous_tab";
      };

      autoThemeFiles = {
        dark = "Catppuccin-Mocha";
        light = "Catppuccin-Latte";
        noPreference = "Catppuccin-Mocha";
      };

      settings = {
	      scrollbaclk_lines = 10000;
	      enable_audio_bell = "no";
	      tab_bar_min_tabs = 1;
	      tab_bar_edge = "bottom";
	      tab_bar_style = "powerline";
	      tab_powerline_style = "slanted";
	      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

	      background_opacity = "1";

	      enabled_layouts = "tall";
      };
    };
  };
}
