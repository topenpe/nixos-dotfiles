{ config, lib, ... }:

{
  options.qtConfig.enable = lib.mkEnableOption "Enable qt configuration";

  config = lib.mkIf config.qtConfig.enable {
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";

      qt5ctSettings = {
        Appearence = {
          style = "kvantum";
          color_scheme = "matugen";
          icon_theme = "Dracula";
          standart_dialogs = "xdgdesktopportal";
        };
        Fonts = {
          general = "\"Liberation Sans,10,-1,5,50,0,0,0,0,0\"";
          fixed = "\"Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0\"";
        };
      };

      qt6ctSettings = {
        Appearence = {
          style = "kvantum";
          color_scheme = "matugen";
          icon_theme = "Dracula";
          standart_dialogs = "xdgdesktopportal";
        };
        Fonts = {
          general = "\"Liberation Sans,10,-1,5,50,0,0,0,0,0\"";
          fixed = "\"Iosevka Nerd Font,10,-1,5,50,0,0,0,0,0\"";
        };
      };
    };
  };
}
