{
  lib,
  config,
  ...
}: {
  options.niriConfig.enable = lib.mkEnableOption "Enable the Niri window manager";

  config = lib.mkIf config.niriConfig.enable {
    wayland.windowManager.niri = {
      enable = true;
    };

    programs = {
      dank-material-shell = {
        enable = true;
        systemd = {
          enable = true;
          restartIfChanged = true;
        };
      };

      dux-files = {
        enable = true;
        systemd.enable = true;
        portal.enable = true;
      };

      dsearch.enable = true;
    };
  };
}
