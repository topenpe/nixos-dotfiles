{ lib, config, ... }:

{
  imports = [
    ./submodules/git.nix
    ./submodules/nushell.nix
    ./submodules/starship.nix
  ];

  nu.enable = lib.mkDefault false;
  pepelatz.enable = true;
  wanker.enable = lib.mkDefault true;
}
