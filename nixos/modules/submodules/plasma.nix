{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.plasma.enable = lib.mkEnableOption "Enable Plasma 6 with SDDM";

  config = lib.mkIf config.plasma.enable {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = [ ];

    services.displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
      autoNumlock = true;
    };

    environment.systemPackages = with pkgs; [ ];

    environment.variables = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = lib.mkDefault "wayland";
      CLUTTER_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
    };
  };
}
