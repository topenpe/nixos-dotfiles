{ lib, config, ... }:

{
  imports = [
    ./submodules/git.nix
    ./submodules/nushell.nix
    ./submodules/starship.nix
  ];

  nushellConfig.enable = lib.mkDefault false;
  starshipConfig.enable = true;
  gitConfig.enable = lib.mkDefault true;

  programs.nix-index.enable = true;
}
