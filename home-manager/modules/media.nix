{ lib, ... }:

{
  imports = [
    ./submodules/cava.nix
    ./submodules/mpd.nix
    ./submodules/mpv.nix
    ./submodules/ncmpcpp.nix
  ];

  kahve.enable = lib.mkDefault true;
  mpdConfig.enable = lib.mkDefault true;
  mpvConfig.enable = lib.mkDefault true;
  ncmpcppConfig.enable = lib.mkDefault true;
}
