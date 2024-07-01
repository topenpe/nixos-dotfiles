{ lib, ... }:

{
  imports = [
    #./submodules/ags.nix
    ./submodules/gtk.nix
    ./submodules/hyprland.nix
    ./submodules/nushell.nix
  ];

  gtkConfig.enable = lib.mkDefault true;
  hyprConfig.enable = lib.mkDefault true;
  #agsConfig.enable = lib.mkDefault true;
}
