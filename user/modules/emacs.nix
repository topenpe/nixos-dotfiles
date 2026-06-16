{ lib, config, pkgs, ... }:

{ # TBD
  options.emacsConfig.enable = lib.mkEnableOption "Enable Emacs configuration";

  config = lib.mkIf config.emacsConfig.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };
  };
}
