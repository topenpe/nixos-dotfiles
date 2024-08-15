{ lib, config, ... }:

{
  imports = [
    ./submodules/git.nix
    ./submodules/kitty.nix
    ./submodules/nushell.nix
    ./submodules/starship.nix
  ];

  gitConfig.enable = lib.mkDefault true;
  kittyConfig.enable = true;
  nushellConfig.enable = lib.mkDefault false;
  starshipConfig.enable = true;

  programs.nix-index.enable = true;
}
