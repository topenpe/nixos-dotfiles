{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.gitConfig.enable = lib.mkEnableOption "Enable git configuration";

  config = lib.mkIf config.gitConfig.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;

      signing = {
        key = "AD9CD6E65C2D0DB6";
        signByDefault = true;
      };

      extraConfig = {
        core = {
          whitespace = "trailing-space,space-before-tab";
        };

        advice.addIgnoredFile = false;

        user = {
          email = "110166186+topenpe@users.noreply.github.com";
          name = "Dmitry Chekmarev-Schreiner";
        };
      };
    };
  };
}
