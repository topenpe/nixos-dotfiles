{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options = {
    hyprConfig.enable = lib.mkEnableOption "Enable Hyprland configuration";
    wallpaper = lib.mkOption {
      default = "${config.home.homeDirectory}/system/wallpapers/andrew-haimerl-r5lF6yp9148-unsplash.jpg";
      type = lib.types.path;
      description = "Path to active wallpaper";
    };
  };

  config = lib.mkIf config.hyprConfig.enable {
    home.packages = [ inputs.bibata-modern-classic-hyprcursor.packages.${pkgs.system}.default ];
    programs = {
      hyprlock = {
        enable = true;
        settings = {
          general = {
            disable_loading_bar = true;
            hide_cursor = true;
            grace = 2;
          };

          background = [
            {
              path = "${config.wallpaper}";
              blur_passes = 3;
              blur_size = 8;
            }
          ];

          input-field = [
            {
              size = "200, 50";
              halign = "center";
              valign = "center";
              position = "0, -80";
              outline_thickness = 5;
              dots_center = true;
              outer_color = "0xff${config.colorScheme.palette.base00}";
              inner_color = "0xff${config.colorScheme.palette.base02}";
              font_color = "0xff${config.colorScheme.palette.base05}";
              check_color = "0xff${config.colorScheme.palette.base0A}";
              fail_color = "0xff${config.colorScheme.palette.base08}";
            }
          ];

          label = [
            {
              halign = "center";
              valign = "center";
              position = "0, 20";
              text = "$TIME";
              text_align = "center";
              color = "0xff${config.colorScheme.palette.base05}";
              font_size = 26;
              font_family = "Iosevka Nerd Font";
            }
          ];
        };
      };
    };

    services = {
      hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
            after_sleep_cmd = "${pkgs.hyprland}/bin/hypctl dispatch dpms on";
          };

          listener = [
            {
              timeout = 1800;
              on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
            }
            {
              timeout = 2400;
              on-timeout = "${pkgs.hyprland}/bin/hypctl dispatch dpms off";
              on-resume = "${pkgs.hyprland}/bin/hypctl dispatch dpms on";
            }
          ];
        };
      };

      hyprpaper = {
        enable = true;
        settings = {
          splash = false;

          preload = [ "${config.wallpaper}" ];

          wallpaper = [ ",${config.wallpaper}" ];
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = [ "--all" ];
      settings = {
        monitor = "HDMI-A-1,1366x768@59,0x0,1";
        "$mainMod" = "SUPER";

        exec-once = [
          #"${pkgs.dunst}/bin/dunst"
          "${pkgs.hyprpaper}/bin/hyprpaper"
          "${pkgs.eww}/bin/eww open bar"
          #"ags"
        ];

        input = {
          kb_layout = "us,ru";
          kb_options = "grp:alt_shift_toggle,ctrl:nocaps";
          numlock_by_default = true;
          follow_mouse = 2;
          accel_profile = "adaptive";
          sensitivity = 0;
        };

        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 2;
          "col.active_border" = "0xff${config.colorScheme.palette.base07}";
          "col.inactive_border" = "0xff${config.colorScheme.palette.base00}";
          resize_on_border = true;
          layout = "master";
        };

        cursor = {
          inactive_timeout = 3;
          no_warps = true;
          hide_on_key_press = true;
        };

        decoration = {
          rounding = 5;
          inactive_opacity = 0.95;
          shadow_range = 6;
          shadow_render_power = 2;
          "col.shadow" = "0xff${config.colorScheme.palette.base03}";
        };

        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
          background_color = "0xff${config.colorScheme.palette.base01}";
          initial_workspace_tracking = 2;
          enable_swallow = true;
          swallow_regex = "^(kitty)$";
        };

        group = {
          "col.border_active" = "0xff${config.colorScheme.palette.base0B}";
          "col.border_inactive" = "0xff${config.colorScheme.palette.base03}";
          "col.border_locked_active" = "0xff${config.colorScheme.palette.base09}";
          "col.border_locked_inactive" = "0xff${config.colorScheme.palette.base03}";
          groupbar = {
            height = 8;
            font_size = 8;
            scrolling = false;
            text_color = "0xff${config.colorScheme.palette.base00}";
            "col.active" = "0xff${config.colorScheme.palette.base0B}";
            "col.inactive" = "0xee${config.colorScheme.palette.base03}";
            "col.locked_active" = "0xff${config.colorScheme.palette.base09}";
            "col.locked_inactive" = "0xee${config.colorScheme.palette.base03}";
          };
        };

        animations = {
          enabled = "yes";

          bezier = [
            "wind, 0.05, 0.9, 0.1, 1"
            "winIn, 0.1, 1.1, 0.1, 1"
            "winOut, 0.3, -0.3, 0, 1"
            "liner, 1, 1, 1, 1"
          ];

          animation = [
            "windows, 1, 5, wind, slide"
            "windowsIn, 1, 4, winIn, slide"
            "windowsOut, 1, 4, winOut, slide"
            "windowsMove, 1, 4, wind, slide"
            "border, 1, 1, liner"
            "borderangle, 1, 30, liner, loop"
            "fade, 1, 5, default"
            "workspaces, 1, 3, wind"
          ];
        };

        master.new_status = "master";

        xwayland.force_zero_scaling = false;

        windowrule = [
          "float,^(electrum)$"
          "float,^(thunar)$"
          "center,^(thunar)$"
          "size 1024 768,^(thunar)$"
          "float,^(dolphin)$"
          "center,^(dolphin)$"
          "size 1024 768,^(dolphin)$"
          "float,title:^(*on QEMU/KVM)$"
          "float,title:^(Media viewer)$" # Telegram's pic viewer
          "move 50% 50%,title:^(Media viewer)$"
          "float,^(Paradox Launcher)$"
          "float,title:^(Friends List)$"
        ];

        bind =
          let
            toggleRofi = pkgs.writeShellScriptBin "toggleRofi" ''
              ${pkgs.procps}/bin/pkill rofi || ${pkgs.rofi-wayland}/bin/rofi -show drun -show-icons -icon-theme Tela dark -theme ${config.home.homeDirectory}/.config/rofi/sidebar.rasi
            '';
            takeScreenshot = pkgs.writeShellScriptBin "takeScreenshot" ''
              mkdir -p ${config.home.homeDirectory}/pictures/screenshots && grim ${config.home.homeDirectory}/pictures/screenshots/$(date +"%Y_%m_%d_%H-%M-%S.png") && ${pkgs.libnotify}/bin/notify-send "Screenshot taken!" && exit ; ${pkgs.libnotify}/bin/notify-send "Unable to take screenshot."
            '';
            takeZonedScreenshot = pkgs.writeShellScriptBin "takeZonedScreenshot" ''
              mkdir -p ${config.home.homeDirectory}/pictures/screenshots && slurp | grim -g - ${config.home.homeDirectory}/pictures/screenshots/$(date +"%Y_%m_%d_%H-%M-%S.png") && ${pkgs.libnotify}/bin/notify-send "Screenshot taken!" && exit ; ${pkgs.libnotify}/bin/notify-send "Unable to take screenshot."
            '';
          in
          [
            "$mainMod, Return, exec, ${pkgs.kitty}/bin/kitty"
            "$mainMod, Q, killactive,"
            "$mainMod, F, fullscreen,"
            "$mainMod SHIFT, F, togglefloating,"

            "$mainMod, G, togglegroup,"
            "$mainMod SHIFT, G, lockactivegroup, toggle"
            "$mainMod, TAB, changegroupactive, f"
            "$mainMod SHIFT, TAB, changegroupactive, b"

            #"$mainMod, R, exec, ${lib.getExe toggleRofi}"
            "$mainMod, R, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"

            "$mainMod SHIFT, P, exec, ${lib.getExe takeZonedScreenshot}"
            "$mainMod, P, exec, ${lib.getExe takeScreenshot}"

            "$mainMod, H, movefocus, l"
            "$mainMod, L, movefocus, r"
            "$mainMod, K, movefocus, u"
            "$mainMod, J, movefocus, d"

            "$mainMod SHIFT, H, movewindow, l"
            "$mainMod SHIFT, L, movewindow, r"
            "$mainMod SHIFT, K, movewindow, u"
            "$mainMod SHIFT, J, movewindow, d"

            "$mainMod CTRL, left, resizeactive, -20 0"
            "$mainMod CTRL, right, resizeactive, 20 0"
            "$mainMod CTRL, up, resizeactive, 0 -20"
            "$mainMod CTRL, down, resizeactive, 0 20"
          ]
          ++ (builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 9;
                  in
                  builtins.toString (x + 1 - (c * 9));
              in
              [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 9
          ))
          ++ ([ ", code:121, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle" ]);

        binde = [
          ", code:122, exec, ${pkgs.wireplumber}/bin/wpctl set-volume --limit 1 @DEFAULT_SINK@ 3%-"
          ", code:123, exec, ${pkgs.wireplumber}/bin/wpctl set-volume --limit 1 @DEFAULT_SINK@ 3%+"
        ];

        bindm = "$mainMod, mouse:272, movewindow";
      };
    };

    home.sessionVariables = {
      HYPRCURSOR_THEME = "bibata-modern-classic-hyprcursor";
      HYPRCURSOR_SIZE = 24;
    };
  };
}
