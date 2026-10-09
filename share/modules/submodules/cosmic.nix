{ lib, config, pkgs, ... }:

{
  options.cosmic.enable = lib.mkEnableOption "Enable COSMIC Desktop Environment";

  config = lib.mkIf config.cosmic.enable {
    services = {
      displayManager.cosmic.enable = false;
      desktopManager.cosmic.enable = true;
    };
    environment.cosmic.excludePackages = with pkgs; [
      cosmic-store
      cosmic-term
    ];
  };
}
