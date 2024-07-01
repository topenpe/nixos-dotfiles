{ lib, config, ... }:

{
  option.pantalaimonConfig.enable = lib.mkEnableOption "Enable Pantalaimon for Matrix";

  config = lib.mkIf config.pantalaimonConfig.enable {
    services.pantalaimon = {
      enable = true;
      settings = {
        main = {
          Homeserver = "https://matrix.org";
        };
      };
    };
  };
}
