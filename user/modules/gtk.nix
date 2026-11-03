{ lib, config, pkgs, ... }:

{
  options.gtkConfig.enable = lib.mkEnableOption "Enable GTK dark theme configuration";

  config = lib.mkIf config.gtkConfig.enable {
    gtk = {
      enable = true;
      colorScheme = "dark";
        theme = {
        package = pkgs.colloid-gtk-theme;
        name = "colloid-gtk-theme: grey dark compact catppuccin";
      };

      font = {
        package = pkgs.nerd-fonts.noto;
        name = "Nerd Font Noto";
        size = 12;
      };

      gtk2.extraConfig = ''
        gtk-application-prefer-dark-theme=1
      '';

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
