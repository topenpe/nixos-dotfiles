{ config, lib, ... }:

{
  options.zshConfig.enable = lib.mkEnableOption "Change zdotdir path";

  config = lib.mkIf config.zshConfig.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      dotDir = "${config.xdg.configHome}/zsh";
      history.path = "${config.xdg.configHome}/zsh/history";
    };
  };
}
