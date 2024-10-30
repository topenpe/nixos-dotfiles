{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.regreet.enable = lib.mkEnableOption "Enable display manager";

  config = lib.mkIf config.regreet.enable {
    programs = {
      regreet = {
        enable = true;
        theme = {
          name = "Catppuccin-Mocha-Compact-Blue-Dark";
          package = pkgs.catppuccin-gtk;
        };
        font.name = "Iosevka Nerd Font";
        iconTheme = {
          name = "Tela";
          package = pkgs.tela-icon-theme;
        };
        settings = {
          background = {
            path = "/home/topenpe/system/wallpapers/wp8.jpg";
          };
          appearance.greeting_msg = "Spirit Inside!";
        };
      };
    };

    services = {
      greetd = {
        enable = true;
        settings.default_session = {
          command = "${pkgs.dbus}/bin/dbus-run-session cage -s -- regreet";
          user = "greeter";
        };
      };
      hypridle.enable = true;
    };

    environment = {
      systemPackages = with pkgs; [ cage greetd.regreet ];
    };
  };
}
