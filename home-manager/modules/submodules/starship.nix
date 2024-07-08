{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.starshipConfig.enable = lib.mkEnableOption "enable Starship configuration";

  config = lib.mkIf config.starshipConfig.enable {
    home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

    programs.starship = {
      enable = true;

      settings = {
        format = lib.concatStrings [
          "[┌─ ](bold blue)$character$git_branch\n"
          "[│](bold blue)$hostname$username$directory\n"
          "[└──────────────](bold blue)$nix_shell[〉](bold blue)"
        ];

        add_newline = false;

        username = {
          style_root = "bold red";
          style_user = "bold green";
          show_always = true;
        };

        hostname = {
          ssh_symbol = " ";
          style = "bold cyan";
        };

        directory = {
          style = "bold cyan";
          read_only = " ";
          read_only_style = "italic red";
          repo_root_style = "bold green";
        };

        nix_shell = {
          symbol = " ";
          style = "bold cyan";
          impure_msg = "";
          pure_msg = "[pure](italic red)";
        };

        git_branch = {
          always_show_remote = false;
          style = "bold magenta";
          truncation_length = 16;
        };

        character = {
          success_symbol = "[ ](bold green)";
          error_symbol = "[](bold red)";
          vimcmd_symbol = "[ ](bold cyan)";
        };
      };
    };
  };
}
