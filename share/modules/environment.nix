{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./submodules/nix-ld.nix
    ./submodules/local-llm.nix
    ./submodules/minecraft.nix
    ./submodules/niri.nix
    ./submodules/nvf.nix
    ./submodules/virtualisation.nix
    ./submodules/zsh.nix
  ];

  # Here I include all the system-wide configuration modules & packages
  # so that I can manage them more easily

  # Enable togglable modules:
  linker.enable = true;
  local-llm.enable = lib.mkDefault false;
  minecraft.enable = lib.mkDefault true;
  niri.enable = lib.mkDefault true;
  nvim.enable = lib.mkDefault true;

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
      (btop.override { rocmSupport = true; })
      freecad
      gimp
      imv
      krita
      librewolf
      monero-cli
      nicotine-plus
      telegram-desktop
      thunderbird
      tor-browser
      transmission_4-gtk
      vesktop
      zathura

      # ai
      llama-cpp-rocm

      # Games
      ckan
      lutris
      prismlauncher

      # Utilities
      android-tools
      cage
      duf
      bandwhich
      brightnessctl
      cron
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
      nix-prefetch-git
      nixfmt
      nmap
      openvpn
      ouch
      pandoc
      parallel
      pass-wayland
      playerctl
      p7zip
      qrencode
      sass
      slurp
      shared-mime-info
      socat
      smartmontools
      strace
      theclicker
      texliveFull
      unzip
      wget
      wineWow64Packages.waylandFull
      xdg-utils
      xwayland-satellite

      # style
      libsForQt5.qtstyleplugin-kvantum
      dracula-icon-theme
      nixos-icons
      apple-cursor

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

    localsend.enable = true;

    steam = {
      enable = true;
      protontricks.enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
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

    power-profiles-daemon.enable = true;
    gvfs.enable = true;

    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}
