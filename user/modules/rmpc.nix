{ lib, config, ... }:

{ # TBD
  options.rmpcConfig.enable = lib.mkEnableOption "Enable rmpc configuration";

  config = lib.mkIf config.rmpcConfig.enable {
    programs.rmpc = {
      enable = true;
      config = ''
        (
          address: "127.0.0.1:6600",
          password: None,
          album_art: (
            method: Auto
          ),
        )
      '';
    };
  };
}
