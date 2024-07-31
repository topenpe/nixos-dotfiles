{ lib, config, ... }:

{
  options.direnvConfig.enable = lib.mkEnableOption "Enable direnv and nix-direnv to keep some of one's sanity";

  config = lib.mkIf config.direnvConfig.enable {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
