{ pkgs, lib, config, options, ... }:

{
  options.nix-ld.enable = lib.mkEnableOption "Enable nix-ld to create a 'global' lib path and make generic Linux binaries work on NixOS.";

  config = lib.mkIf config.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [ libGL ] );
    };
  };
}
