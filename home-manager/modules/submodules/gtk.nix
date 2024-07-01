{ pkgs, lib, config, ... }:

{
  options.gitty.enable = lib.mkEnableOption "Enable GTK settings";

  config = lib.mkIf config.gitty.enable {
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.tela-icon-theme;
        name = "Tela";
      };

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

      theme = {
        name = "Catppuccin-Mocha-Compact-Blue-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "blue" ];
          size = "compact";
          tweaks = [ "rimless" ];
          variant = "mocha";
        };
      };
    };
  };
}
