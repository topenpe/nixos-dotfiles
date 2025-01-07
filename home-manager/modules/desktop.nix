{ lib, ... }:

{
  imports = [
    ./submodules/eww.nix
    ./submodules/gtk.nix
    ./submodules/hyprland.nix
    ./submodules/nushell.nix
  ];

  eww.enable = true;
  gtkConfig.enable = lib.mkDefault true;
  hyprConfig.enable = lib.mkDefault true;
  nushellConfig.enable = false;
}
