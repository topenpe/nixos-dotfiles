{ pkgs, lib, config, ... }:

{
  options.gitConfig.enable = lib.mkEnableOption "Enable git configuration";

  config = lib.mkIf config.gitConfig.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;

      extraConfig = {
        core = {
          whitespace = "trailing-space,space-before-tab";
        };

        user = {
          email = "dcschreiner@airmail.cc";
          name = "Dmitry Chekmarev-Schreiner";
          signingKey = "${config.home.homeDirectory}/.ssh/reimu.pub";
        };

        gpg = {
          format = "ssh";
        };
      };
    };
  };
}
