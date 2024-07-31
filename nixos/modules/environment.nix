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
    ./submodules/plasma.nix
    ./submodules/zsh.nix
  ];

  archie.enable = false;
  direnvConfig.enable = true;
  zshConfiguration.enable = true;
  hyprlandDesktop.enable = true;
  plasma.enable = false;

  environment = {
    defaultPackages = with pkgs; [
      file
      inetutils
      iputils
      perl
      rsync
    ];

    systemPackages = with pkgs; [

      # Programmes
      #anytype
      #armcord
      btop
      electrum
      element-desktop
      (import ./submodules/emacs.nix { inherit pkgs; })
      #gimp
      gtypist
      heroic
      #iamb
      #imgbrd-grabber
      imv
      kitty
      librewolf
      #lmms
      monero-cli
      #prismlauncher
      telegram-desktop
      thunderbird
      #tor-browser
      transmission_4-gtk
      zathura

      # Games
      #flightgear

      # Utilities
      bandwhich
      brightnessctl
      cron
      du-dust
      glxinfo
      grim
      inxi
      jc
      jq
      #kdiskmark
      lsd
      lynx
      #mangohud
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
      slurp
      socat
      #soundconverter
      smartmontools
      #texlive.combined.scheme-full
      ton
      #unzip
      wget
      #wineWowPackages.waylandFull

      libimobiledevice
      ifuse
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

#    nh = {
#      enable = true;
#      #package = pkgs.callPackage ../../overrides/nh/package.nix { };
#      clean = {
#        enable = true;
#        extraArgs = "--keep 5";
#      };
#    };

    steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = false;
    };

    gamemode = {
      enable = false;
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

    udisks2.enable = true;

    usbmuxd = {
      enable = false;
      package = pkgs.usbmuxd2;
    };
  };
}
