{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./submodules/archie.nix
    ./submodules/hyprland.nix
    ./submodules/plasma.nix
    ./submodules/zsh.nix
  ];

  archie.enable = true;
  zshConfiguration.enable = true;
  hyprlandDesktop.enable = true;
  plasma.enable = false;

  environment = {
    defaultPackages = with pkgs; [
      file
      perl
      rsync
    ];

    systemPackages = with pkgs; [

      # Programmes
      anytype
      armcord
      btop
      electrum
      element-desktop
      (import ./submodules/emacs.nix { inherit pkgs; })
      gimp
      gtypist
      heroic
      iamb
      #imgbrd-grabber
      imv
      kitty
      librewolf
      lmms
      monero-cli
      prismlauncher
      telegram-desktop
      thunderbird
      tor-browser
      transmission_4-gtk
      zathura

      # Utilities
      brightnessctl
      cron
      du-dust
      glxinfo
      grim
      jc
      jq
      kdiskmark
      lsd
      lynx
      mangohud
      mpc-cli
      nitch
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
      soundconverter
      smartmontools
      texlive.combined.scheme-full
      unzip
      wget
      wineWowPackages.waylandFull

      libimobiledevice
      ifuse
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      FLAKE = ../..;
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
      #package = pkgs.callPackage ../../overrides/nh/package.nix { };
      clean = {
        enable = true;
        extraArgs = "--keep 5";
      };
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

    udisks2.enable = true;

    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
  };
}
