{ pkgs, lib, config, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./modules/custodia.nix
    ./modules/desktop.nix
    ./modules/media.nix
    ./modules/terminal.nix
  ];

  home = {
    username = "topenpe";
    homeDirectory = "/home/topenpe";
    stateVersion = "23.05";
    sessionVariables = {
      GOPATH = "$HOME/.local/share/go";
			QUOTING_STYLE = "literal";
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  xdg = {
    cacheHome = "${config.xdg.dataHome}/cache";
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      publicShare = null;
      templates = null;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      videos = "${config.home.homeDirectory}/videos";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    dotDir = ".config/zsh";
    history.path = ".config/zsh/zsh_history";
  };
}
