{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options.hyprlandDesktop.enable = lib.mkEnableOption "Enable Hyprland ecosystem";

  config = lib.mkIf config.hyprlandDesktop.enable {
    programs = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        xwayland.enable = true;
      };
      hyprlock.enable = true;
      dconf.enable = true;

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
      systemPackages = with pkgs; [ cage greetd.regreet hyprcursor ];

      variables = {
        GRIM_DEFAULT_DIR = "$HOME/pictures/screenshots";
        NIXOS_OZONE_WL = "1";
        GDK_BACKEND = lib.mkDefault "wayland";
        CLUTTER_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORM = "wayland";
      };
    };
  };
}
