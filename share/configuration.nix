{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/environment.nix
    ./modules/filesystems.nix
    ./modules/keyboard.nix
    ./modules/network.nix
    ./modules/fonts.nix
  ];

  # This is one of the three main configuration files.
  # In it, I import other modules & manage stuff like
  # bootloader and kernel modules.
  #
  # Packages are managed in ./modules/environment.nix
  # or via home-manager at ../user

  system.stateVersion = "25.11";
  time.timeZone = "America/Montevideo";
  i18n.defaultLocale = "en_US.UTF-8";

  # Togglable options from my modules:
  mounters.enable = true;
  biermannLayout.enable = true;

  home-manager = {
    backupFileExtension = "backup";
    useUserPackages = true;
  };

  boot = {
    # Choose a kernel package from linuxKernel.packages:
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;

    tmp.cleanOnBoot = true;
    loader = {
      # Bootloader options:
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "1920x1080";
        theme = pkgs.stdenv.mkDerivation {
          name = "catppuccin-grub";
          src = pkgs.fetchFromGitHub {
            owner = "topenpe";
            repo = "catppuccin-grub";
            rev = "ac772b04dfc9ba4fbebe3b6bad7b9a6812aee35a";
            hash = "sha256-wMHktlkAv7j0eAhCGoatn7kCFL/EfgIhBIg8J94wjNU=";
          };

          installPhase = "mkdir -p $out/ && cp -r src/catppuccin-mocha-grub-theme/* $out/";
        };
        configurationLimit = 3;
      };
    };

    plymouth = {
      # An (admittedly ginormous) plymouth theme w/ some settings:
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "lone";
      logo = "${pkgs.emptyFile}";
      extraConfig = "ShowDelay=0";
    };

    kernelParams = [
      # My parameters include queter-than-standart boot
      # and catppuccin colours for the tty.
      # This is all obviously highly opinionated
      "quiet"
      "loglevel=2"
      "systemd.show_status=auto"
      "udev.log_level=2"
      "splash"
      "pcie_aspm=off"
      "amdgpu.ppfeaturemask=0xfffd7fff"
      "vt.global_cursor_default=0"
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];
  };

  hardware = {
    # You might have to add more here if you have an NVIDIA GPU:
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    enableAllFirmware = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "@wheel" ];
      experimental-features = [
        # Enabling flakes is essential since this is a flake setup:
        "flakes"
        "nix-command"
      ];
    };
  };

  # Creating a user here:
  users = {
    # zsh is my shell of choice (yes for root too):
    defaultUserShell = pkgs.zsh;
    groups = {
      wheel = { };
      adbusers = { };
      gamemode = { };
      networkmanager = { };
      video = { };
      wireshark = { };
      kvm = { };
      libvirt = { };
      mpd = { };
    };
    # Change to your username here:
    users.topenpe = {
      shell = pkgs.zsh;
      isNormalUser = true;

      # This actually lets you login with an empty password,
      # so change to your preferred password, salted or not,
      # or unset users.mutableUsers from false and change it imperatively.
      # (or don’t do anything if you don’t care):
      hashedPassword = "";

      extraGroups = [
        "wheel"
        "adbusers"
        "gamemode"
        "networkmanager"
        "video"
        "wireshark"
        "kvm"
        "libvirt"
        "mpd"
      ];
      createHome = true;
    };
  };
  users.users.root.hashedPassword = ""; # Same point as before.
  # This option disallows adding, removing or modifying users imperatively:
  users.mutableUsers = false;

  # Since I’m accustomed to using doas I’ve disabled sudo completely.
  # Just remove the security block if you prefer sudo, it’s the default:
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          noPass = true;
        }
      ];
    };
  };
}
