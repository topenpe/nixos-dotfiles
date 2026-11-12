{
  lib,
  config,
  pkgs,
  ...
}: {
  options.gtkConfig.enable = lib.mkEnableOption "Enable GTK configuration";

  config = lib.mkIf config.gtkConfig.enable {
    gtk = {
      enable = true;
      colorScheme = "dark";
      cursorTheme = {
        package = pkgs.apple-cursor;
        name = "macOS";
        size = 24;
      };
      theme = {
        package = pkgs.colloid-gtk-theme;
        name = "colloid-gtk-theme: grey dark compact catppuccin";
      };
      iconTheme = {
        package = pkgs.dracula-icon-theme;
        name = "Dracula";
      };

      gtk4 = {
        enable = true;
        colorScheme = "dark";
        cursorTheme = {
          package = pkgs.apple-cursor;
          name = "macOS";
          size = 24;
        };
        theme = {
          package = pkgs.colloid-gtk-theme;
          name = "colloid-gtk-theme: grey dark compact catppuccin";
        };
        iconTheme = {
          package = pkgs.dracula-icon-theme;
          name = "Dracula";
        };
      };

      gtk3 = {
        enable = true;
        colorScheme = "dark";
        cursorTheme = {
          package = pkgs.apple-cursor;
          name = "macOS";
          size = 24;
        };
        theme = {
          package = pkgs.colloid-gtk-theme;
          name = "colloid-gtk-theme: grey dark compact catppuccin";
        };
        iconTheme = {
          package = pkgs.dracula-icon-theme;
          name = "Dracula";
        };
      };
    };
  };
}
