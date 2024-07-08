{ lib, ... }:

{
  imports = [ ./submodules/udiskie.nix ];

  udiskieConfig.enable = lib.mkDefault true;
}
