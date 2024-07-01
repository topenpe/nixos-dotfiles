{ pkgs, lib, config, ... }:

{
  options.starshipConfig.enable = lib.mkEnableOption "enable Starship configuration";

  config = lib.mkIf config.starshipConfig.enable {
    home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

    programs.starship = let flavour = "mocha"; in {
      enable = true;

      settings = {
        format = lib.concatStrings [
          "[┌──────────────┤](bold blue)$character$git_branch$git_commit\n"
          "[│](bold blue)$hostname$username$directory\n"
          "[└─](bold blue)$nix_shell$rlang$git_status[〉](bold blue)"
        ];

        add_newline = false;

        username = {
          style_root = "bold red";
          style_user = "bold yellow";
          show_always = true;
        };

        hostname = {
          ssh_symbol = " ";
          style = "bold dimmed yellow";
        };

        directory = {
          style = "bold cyan";
          read_only = " ";
          read_only_style = "italic red";
          repo_root_style = "bold purple";
        };

        nix_shell = {
          symbol = " ";
          style = "bold cyan";
          impure_msg = "";
          pure_msg = "[pure](italic purple)";
        };

        rlang = {
          symbol = "  ";
          version_format = "v\${minor}";
          style = "bold cyan";
          detect_extensions = [
            "R" "Rd" "Rmd" "Rproj" "Rsx"
            "r" "rd" "rmd" "rproj" "rsx"
          ];
        };

        git_branch = {
          always_show_remote = false;
          style = "bold purple";
          truncation_length = 16;
        };

        git_commit = {
          commit_hash_length = 7;
          format = "// [\\($tag:$hash\\)](dimmed purple) ";
          tag_disabled = false;
          tag_symbol = " ";
        };

        git_status = {
          conflicted = " ";
          ahead = " ";
          behind = " ";
          diverged = " ";
          up_to_date = " ";
          untracked = " ";
          stashed = " ";
          modified = " ";
          staged = " ";
          renamed = " ";
          deleted = " ";
          style = "bold red";
        };

        character = {
          success_symbol = "[ ](bold green)";
          error_symbol = "[](bold red)";
          vimcmd_symbol = "[ ](bold green)";
        };

        palette = "catppuccin_${flavour}";
      } // builtins.fromTOML (builtins.readFile
      (pkgs.fetchFromGitHub {
       owner = "catppuccin";
       repo = "starship";
       rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
       sha256 = "1bdm1vzapbpnwjby51dys5ayijldq05mw4wf20r0jvaa072nxi4y";
       } + /palettes/${flavour}.toml));
    };
  };
}
