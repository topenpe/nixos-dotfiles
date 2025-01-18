{ lib, ... }:

{
  imports = [
    ./submodules/eww.nix
    ./submodules/gtk.nix
    ./submodules/hyprland.nix
    ./submodules/nushell.nix
    ./submodules/wlsunset.nix
  ];

  eww.enable = true;
  gtkConfig.enable = lib.mkDefault true;
  hyprConfig.enable = lib.mkDefault true;
  nushellConfig.enable = false;
  wlsunsetConfig.enable = true;
}
