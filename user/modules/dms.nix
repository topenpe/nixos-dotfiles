{ inputs, ... }:

{ # TBD
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.niri.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;
    niri.enableSpawn = true;
    settings = {
      currentThemeCategory = "auto";
      matugenScheme = "scheme-vibrant";
      cornerRadius = 0;

      widgetBackgroundColor = "sc";

      niriLayoutGapsOverride = 1;
      niriLayoutRadiusOverride = 1;
      niriLayoutBorderOverride = 1;

      animationSpeed = 4;
      customAnimationDuration = "250";

      blurWallpaperOnOverview = true;

      windSpeedUnit = "ms";


    };
  };
}
