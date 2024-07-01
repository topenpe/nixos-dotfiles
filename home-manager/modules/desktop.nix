{ lib, ... }:

{
  imports = [
    ./submodules/ags.nix
    ./submodules/gtk.nix
    ./submodules/hyprland.nix
    ./submodules/nushell.nix
  ];

  gitty.enable = lib.mkDefault true;
  hyprConfig.enable = lib.mkDefault true;
  widgets.enable = lib.mkDefault true;
}
