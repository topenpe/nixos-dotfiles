{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/environment.nix
    ./modules/fonts.nix
    ./modules/network.nix
    ./modules/virtualisation.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.11";
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Tbilisi";
  i18n.defaultLocale = "en_US.UTF-8";
  sound.enable = true;

  queenOfVirt.enable = true;

  boot = {
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.verbose = false;
    consoleLogLevel = 0;

    kernelParams = [
      "quiet"
      "loglevel=2"
      "udev.log_level=2"
      "pcie_aspm=off"
      "nvme_core.default_ps_max_latency_us=0"
      "nvme_core.io_timeout=255"
      "nvme_core.max_retries=10"
      "nvme_core.shutdown_timeout=10"
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
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
      experimental-features = [ "flakes" "nix-command" "no-url-literals" ];
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    groups = { wheel = {}; gamemode = {}; networkmanager = {}; video = {}; libvirt = {}; mpd = {}; };
    users.topenpe = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" "gamemode" "networkmanager" "video" "libvirt" "mpd" ];
      createHome = true;
    };
  };

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        persist = true;
      }];
    };
  };
}
