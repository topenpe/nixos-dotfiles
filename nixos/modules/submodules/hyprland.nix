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

    environment = {
      systemPackages = with pkgs; [ cage greetd.regreet hyprcursor hyprpanel ];

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
