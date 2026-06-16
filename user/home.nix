{ ... }:

{ # All modules togglable for convenience
  imports = [
    ./modules/emacs.nix
    ./modules/gtk.nix
    ./modules/mpd.nix
    ./modules/mpv.nix
    ./modules/nh.nix
    ./modules/kitty.nix
    ./modules/qt.nix
    ./modules/rmpc.nix
    ./modules/xdg.nix
    ./modules/yazi.nix
    ./modules/zsh.nix
  ];

  home = { # change to your username obv:
    username = "topenpe";
    uid = 1000;
    homeDirectory = "/home/topenpe";
    preferXdgDirectories = true;
    stateVersion = "25.11";
  };

  emacsConfig.enable = true;
  gtkConfig.enable = true;
  mpvConfig.enable = true;
  mpdConfig.enable = true;
  nhConfig.enable = true;
  kittyConfig.enable = true;
  qtConfig.enable = true;
  rmpcConfig.enable = true;
  xdgConfig.enable = true;
  yaziConfig.enable = true;
  zshConfig.enable = true;
}
