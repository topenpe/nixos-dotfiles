{
  lib,
  config,
  ...
}:

{
  options.wlsunsetConfig.enable = lib.mkEnableOption "Enable wlsunset";

  config = lib.mkIf config.wlsunsetConfig.enable {
    services.wlsunset = {
      enable = true;
      sunrise = "8:25";
      sunset = "18:00";
      temperature = {
        day = 6500;
        night = 5000;
      };
    };
  };
}
