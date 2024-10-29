{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./submodules/archie.nix
    ./submodules/direnv.nix
    ./submodules/hyprland.nix
    ./submodules/nix-ld.nix
    ./submodules/plasma.nix
    ./submodules/zsh.nix
  ];

  archie.enable = true;
  direnvConfig.enable = true;
  zshConfiguration.enable = true;
  hyprlandDesktop.enable = true;
  generic.enable = true;
  plasma.enable = false;

  environment = {
    defaultPackages = with pkgs; [
      busybox
      file
      inetutils
      iputils
      perl
      rsync
    ];

    systemPackages = with pkgs; [

      # Programmes
      anki
      ardour
      (btop.override { rocmSupport = true; })
      electrum
      element-desktop
      (import ./submodules/emacs.nix { inherit pkgs; })
      gimp
      gtypist
      heroic
      #iamb
      #imgbrd-grabber
      imv
      kitty
      legcord
      librewolf
      lmms
      monero-cli
      stellarium
      telegram-desktop
      thunderbird
      tor-browser
      transmission_4-gtk
      zathura

      # Games
      flightgear
      prismlauncher

      # Utilities
      #bandwhich
      brightnessctl
      cron
      du-dust
      fastfetch
      glxinfo
      grim
      inxi
      jc
      jq
      kdiskmark
      lsd
      lynx
      mangohud
      mpc-cli
      nix-prefetch-git
      nixfmt-rfc-style
      nmap
      openvpn
      pandoc
      parallel
      pass-wayland
      p7zip
      qrencode
      rofi-wayland
      #rofi-calc
      #rofi-emoji
      sass
      slurp
      socat
      soundconverter
      smartmontools
      texlive.combined.scheme-full
      ton
      unzip
      wget
      wineWowPackages.waylandFull

      # temp
      android-tools
      heimdall-gui
      jdk17
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      FLAKE = "$HOME/system";
      GOPATH = "$HOME/.local/share/go";
      QUOTING_STYLE = "literal";
    };
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = lib.mkForce pkgs.pinentry-curses;
    };

    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
    };

    nh = {
      enable = true;
    };

    steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
    };

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

    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
  };
}
