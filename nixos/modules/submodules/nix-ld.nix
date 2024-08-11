{ lib, config, ... }:

{
  options.generic.enable = lib.mkEnableOption "Enable nix-ld to create a 'global' lib path and make generic Linux binaries work on NixOS.";

  config = lib.mkIf config.generic.enable {
    programs.nix-ld = {
      enable = true;
    };
  };
}
