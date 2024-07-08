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
    };

    services = {
      greetd = {
        enable = true;
        settings.default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --cmd Hyprland";
          user = "greeter";
        };
      };
      hypridle.enable = true;
    };

    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        config.common.default = "*";
      };
    };

    environment = {
      systemPackages = with pkgs; [ ];

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
