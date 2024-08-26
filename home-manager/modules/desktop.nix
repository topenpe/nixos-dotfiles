{ lib, ... }:

{
  imports = [
    ./submodules/ags.nix
    ./submodules/eww.nix
    ./submodules/gtk.nix
    ./submodules/hyprland.nix
    ./submodules/nushell.nix
  ];

  agsConfig.enable = true;
  eww.enable = true;
  gtkConfig.enable = lib.mkDefault true;
  hyprConfig.enable = lib.mkDefault true;
  nushellConfig.enable = false;
}
