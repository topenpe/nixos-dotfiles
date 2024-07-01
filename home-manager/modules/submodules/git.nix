{ pkgs, lib, config, ... }:

{
  options.wanker.enable = lib.mkEnableOption "Enable git configuration";

  config = lib.mkIf config.wanker.enable {
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
        };
      };
    };
  };
}
