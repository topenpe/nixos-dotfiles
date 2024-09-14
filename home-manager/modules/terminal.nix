{ inputs, lib, config, ... }:

{
  imports = [
inputs.nixvim.homeManagerModules.nixvim
    ./submodules/git.nix
    ./submodules/kitty.nix
    ./submodules/nixvim.nix
    ./submodules/nushell.nix
    ./submodules/starship.nix
  ];

  gitConfig.enable = lib.mkDefault true;
  kittyConfig.enable = true;
  nixvimConfig.enable = true;
  nushellConfig.enable = lib.mkDefault false;
  starshipConfig.enable = true;

  programs.nix-index.enable = true;
}
