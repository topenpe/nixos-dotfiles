{
  pkgs,
  lib,
  config,
  ...
}:
with pkgs;
let
  archie = rWrapper.override {
    packages = with rPackages; [
      ggplot2
      rmarkdown
      maps
      pagedown
      blogdown
    ];
  };
in
{
  options.archie.enable = lib.mkEnableOption "Enable R language for statistics with custom packages";

  config = lib.mkIf config.archie.enable {
    environment = {
      systemPackages = [ archie ];
    };
  };
}
