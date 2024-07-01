{ pkgs, lib, config, ... }:

{
  options.hyprConfig.enable = lib.mkEnableOption "Enable Hyprland configuration";

  config = lib.mkIf config.hyprConfig.enable {
    programs = {
      hyprlock = {
        enable = true;
        settings = {
          general = {
            disable_loading_bar = true;
            hide_cursor = true;
            grace = 2;
          };

          background = [{
            path = "${config.home.homeDirectory}/system/wallpapers/wp4.jpg";
            blur_passes = 3;
            blur_size = 8;
          }];

          input-field = [{
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
          }];

          label = [{
            halign = "center";
            valign = "center";
            position = "0, 20";
            text = "$TIME";
            text_align = "center";
            color = "0xff${config.colorScheme.palette.base05}";
            font_size = 26;
            font_family = "Iosevka Nerd Font";
          }];
        };
      };
    };

    services = {
      hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "hyprlock";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };

          listener = [
          { timeout = 600; on-timeout = "hyprlock"; }
          { timeout = 1500; on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on"; }];
        };
      };

      hyprpaper = {
        enable = true;
        settings = {
          splash = false;

          preload = [
            "${config.home.homeDirectory}/system/wallpapers/wp4.jpg"
          ];

          wallpaper = [ "HDMI-A-1,${config.home.homeDirectory}/system/wallpapers/wp4.jpg" ];
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
          "dunst"
          "hyprpaper"
          "eww open bar"
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
          "float,title:^(Media viewer)$" #Telegram's pic viewer
          "move 50% 50%,title:^(Media viewer)$"
          "float,^(Paradox Launcher)$"
          "float,title:^(Friends List)$"
        ];

        bind = [
          "$mainMod, Return, exec, kitty"
          "$mainMod, Q, killactive,"
          "$mainMod, F, fullscreen,"
          "$mainMod SHIFT, F, togglefloating,"

          "$mainMod, G, togglegroup,"
          "$mainMod SHIFT, G, lockactivegroup, toggle"
          "$mainMod, TAB, changegroupactive, f"
          "$mainMod SHIFT, TAB, changegroupactive, b"

          "$mainMod, R, exec, pkill rofi || rofi -show drun -show-icons -icon-theme Tela dark -theme $HOME/.config/rofi/sidebar.rasi"
          "$mainMod, SPACE, exec, pkill rofi || rofi -show calc -modi calc -no-show-match -no-sort -theme $HOME/.config/rofi/sidebar.rasi"
          "$mainMod SHIFT, E, exec, pkill rofi || rofi -modi emoji -show emoji -theme $HOME/.config/rofi/sidebar.rasi"

          "$mainMod SHIFT, P, exec, mkdir -p $HOME/pictures && mkdir -p $HOME/pictures/screenshots && slurp | grim -g - $HOME/pictures/screenshots/$(date + '%Y_%m_%d_%H-%M-%S.png') && dunstify 'Screenshot taken!' && exit ; dunstify -u normal 'Unable to take screenshot.'"
          "$mainMod, P, exec, mkdir -p $HOME/pictures && mkdir -p $HOME/pictures/screenshots && grim $HOME/pictures/screenshots/$(date + '%Y_%m_%d_%H-%M-%S.png') && dunstify 'Screenshot taken!' && exit ; dunstify -u normal 'Unable to take screenshot.'"

          "$mainMod SHIFT, B, exec, killall dunst && dunst & sleep 1 && dunstify 'Notification restarted.'"

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
          ++ (
            builtins.concatLists (builtins.genList (
              x: let ws = let c = (x + 1) / 9;
                in builtins.toString (x + 1 - (c * 9)); in [
                  "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ])
              9))
          ++ ([ ", code:121, exec, wpctl set-mute @DEFAULT_SINK@ toggle" ]);

        binde = [
          ", code:232, exec, brightnessctl s 5%-"
          ", code:233, exec, brightnessctl s 5%+"
          "CTRL, code:232, exec, brightnessctl -d kbd_backlight s 5%-"
          "CTRL, code:233, exec, brightnessctl -d kbd_backlight s 5%+"
          ", code:122, exec, wpctl set-volume --limit 1 @DEFAULT_SINK@ 3%-"
          ", code:123, exec, wpctl set-volume --limit 1 @DEFAULT_SINK@ 3%+"
        ];

        bindm = "$mainMod, mouse:272, movewindow";
      };
    };
  };
}
