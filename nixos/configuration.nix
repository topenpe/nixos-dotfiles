{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./modules/environment.nix
    ./modules/filesystems.nix
    ./modules/fonts.nix
    ./modules/network.nix
    ./modules/swap.nix
    ./modules/virtualisation.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.11";
  time.timeZone = "Asia/Tbilisi";
  i18n.defaultLocale = "en_US.UTF-8";

  mounters.enable = lib.mkDefault true;
  swap.enable = true;
  queenOfVirt.enable = false;

  console.useXkbConfig = true;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
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
        configurationLimit = 10;
      };
    };

    initrd.verbose = false;
    consoleLogLevel = 0;

    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "lone";
      logo = "${pkgs.emptyFile}";
      extraConfig = "ShowDelay=0";
    };

    kernelParams = [
      "quiet"
      "loglevel=2"
      "systemd.show_status=auto"
      "udev.log_level=2"
      "splash"
      "pcie_aspm=off"
      "nvme_core.default_ps_max_latency_us=0"
      "nvme_core.io_timeout=255"
      "nvme_core.max_retries=10"
      "nvme_core.shutdown_timeout=10"
      "vt.global_cursor_default=0"
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];
  };

  hardware = {
    bluetooth = {
      enable = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "flakes"
        "nix-command"
        "no-url-literals"
      ];
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    groups = {
      wheel = { };
      adbusers = { };
      gamemode = { };
      networkmanager = { };
      video = { };
      wireshark = { };
      libvirt = { };
      mpd = { };
    };
    users.topenpe = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "adbusers"
        "gamemode"
        "networkmanager"
        "video"
        "wireshark"
        "libvirt"
        "mpd"
      ];
      createHome = true;
    };
  };

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          persist = true;
        }
      ];
    };
  };
}
