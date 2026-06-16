{ lib, config, pkgs, ... }:

{ # I’ve been using niri + DMS, niri is configured with home-manager:
  options.dms.enable = lib.mkEnableOption "Enable Dank Material Shell";

  config = lib.mkIf config.dms.enable {
    # Enable & set up the DMS display manager
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      logs = {
        save = false;
        path = "/var/log/dms-greeter.log";
      };
      configHome = "/home/topenpe";
    };

    # config portal
    xdg.portal = {
      enable = true;
      config = {
        common = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        };
      };
      wlr = {
        enable = true;
        settings = {
          screencast = {
            output_name = "HDMA-A-1";
            chooser_type = "none";
            exec_before = "${pkgs.libnotify}/bin/notify-send 'Screensharing' 'Screensharing started'";
            exec_after = "${pkgs.libnotify}/bin/notify-send 'Screensharing' 'Screensharing ended'";
          };
        };
      };
    };

    # config dconf profile
    programs.dconf = {
      enable = true;
      profiles.topenpe.databases = [
        { settings."org/gnome/desktop/interface".color-scheme = "prefer-dark"; }
      ];
    };

    # and then enable DMS itself
    programs.dms-shell = {
      enable = true;
      enableCalendarEvents = false;
    };
    programs.niri = {
      enable = true;
      useNautilus = false;
    };
  };
}
