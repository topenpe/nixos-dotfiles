{ pkgs, lib, config, ... }:

{
  options.nushellConfig.enable = lib.mkEnableOption "Enable basic Nushell configuration";

  config = lib.mkIf config.nushellConfig.enable {
    programs = {
      carapace = {
        enable = true;

        enableZshIntegration = false;
        enableBashIntegration = false;
      };

      nushell = {
        enable = true;

        extraConfig = ''
          let carapace_completer = {|spans|
            carapace $spans.0 nushell $spans | from json
          }
          $env.config = {
            show_banner: false,
            completions: {
              case_sensitive: false
              quick: true
              partial: false
              algorithm: "fuzzy"
              external: {
                enable: true
                max_results: 100
                completer: $carapace_completer
              }
            }
          }
          $env.PATH = ($env.PATH |
          split row (char esep)  |
          append /usr/bin/env
          )
        '';

        shellAliases = {
        };
      };
    };
  };
}
