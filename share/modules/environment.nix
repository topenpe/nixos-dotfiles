{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./submodules/dms.nix
    ./submodules/nvf.nix
    ./submodules/rtorrent.nix
    ./submodules/virtualisation.nix
    ./submodules/zsh.nix
  ];

  # Here I include all the system-wide configuration modules & packages
  # so that I can manage them more easily

  # Enable togglable modules:
  dms.enable = lib.mkDefault true;
  nvim.enable = lib.mkDefault true;
  rtorrent-service.enable = lib.mkDefault true;

  environment = {
    # You can add more directories to be symlinked in /run/current-system/sw for system-wide access:
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];

    # I excluded some default packages that I don’t need:
    defaultPackages = with pkgs; [
      busybox
      file
      inetutils
      iputils
      perl
      rsync
    ];

    # The big list itself:
    systemPackages = with pkgs; [

      # Programmes
      alacritty
      blender
      (btop.override { rocmSupport = true; })
      freecad
      gimp
      imv
      krita
      librewolf
      monero-cli
      nicotine-plus
      nyxt
      orca-slicer
      telegram-desktop
      thunderbird
      tor-browser
      transmission_4-gtk
      ungoogled-chromium
      vesktop
      zathura

      # Games
      ckan
      (lutris.override {
        # thanks to MOIS3Y @ https://github.com/NixOS/nixpkgs/issues/513245
        # Intercept buildFHSEnv to modify target packages
        buildFHSEnv =
          args:
          pkgs.buildFHSEnv (
            args
            // {
              multiPkgs =
                envPkgs:
                let
                  # Fetch original package list
                  originalPkgs = args.multiPkgs envPkgs;

                  # Disable tests for openldap
                  customLdap = envPkgs.openldap.overrideAttrs (_: {
                    doCheck = false;
                  });
                in
                # Replace broken openldap with the custom one
                builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
            }
          );
      })
      prismlauncher
      stockfish

      # Utilities
      android-tools
      cage
      duf
      kdePackages.ark
      bandwhich
      brightnessctl
      cron
      kdePackages.dolphin
      dust
      fastfetch
      ffmpeg
      grim
      inxi
      jc
      jq
      lsd
      lynx
      mangohud
      mpc
      mtpfs
      nix-prefetch-git
      nixfmt
      nmap
      openvpn
      ouch
      pandoc
      parallel
      pass-wayland
      p7zip
      qrencode
      sass
      slurp
      shared-mime-info
      socat
      soundconverter
      smartmontools
      strace
      theclicker
      texliveFull
      unzip
      wget
      wineWow64Packages.waylandFull
      xwayland-satellite

      # style
      libsForQt5.qtstyleplugin-kvantum
      dracula-icon-theme
      materia-theme
      nixos-icons
      graphite-cursors
      apple-cursor
      whitesur-cursors
      posy-cursors

      # temp
    ];

    variables = {
      # I assume one user setup so packages AND env’s
      # go to system-wide configuration
      EDITOR = "nvim";
      VISUAL = "nvim";
      FLAKE = "$HOME/system";
      GOPATH = "$HOME/.local/share/go";
      DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet/";
      QUOTING_STYLE = "literal";
      GTK_THEME = "Materia:dark";
    };
  };

  programs = {
    # Here I declare options for programmes
    # that don’t need a lot of configuration going.
    #
    # More convoluted configurations need separate modules
    # or are configured with home-manager
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = lib.mkForce pkgs.pinentry-curses;
    };

    # TEMP
    hyprland = {
      enable = true;
      withUWSM = true;
    };

    localsend.enable = true;

    steam = {
      enable = true;
      protontricks.enable = true;
    };

    gamescope.enable = true;

    gamemode = {
      enable = true;
      settings = {
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode stopped'";
        };
      };
    };

    git = {
      enable = true;
    };
  };

  services = {
    # Essential services:
    btrfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;

      wireplumber = {
        enable = true;
      };
    };

    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}
