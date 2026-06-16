{ lib, config, pkgs, ... }:

{
  options.xdgConfig.enable = lib.mkEnableOption "Configure XDG home directories & stuff";

  config = lib.mkIf config.xdgConfig.enable {
    xdg = {
      cacheHome = "${config.xdg.dataHome}/cache";
      userDirs = {
        setSessionVariables = true;

        enable = true;
        createDirectories = true;
        desktop = null;
        publicShare = null;
        templates = null;
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        music = "${config.home.homeDirectory}/music";
        pictures = "${config.home.homeDirectory}/pictures";
        videos = "${config.home.homeDirectory}/videos";
      };

      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = [ "librewolf.desktop" ];
          "x-scheme-handler/http" = [ "librewolf.desktop" ];
          "x-scheme-handler/https" = [ "librewolf.desktop" ];

          "text/plain" = [ "emacs.desktop" ];
          "application/json" = [ "emacs.desktop" ];
          "application/xml" = [ "emacs.desktop" ];
          "text/xml" = [ "emacs.desktop" ];

          "image/png" = [ "imv.desktop" ];
          "image/jpeg" = [ "imv.desktop" ];
          "image/gif" = [ "imv.desktop" ];
          "image/webp" = [ "imv.desktop" ];
          "image/*" = [ "imv.desktop" ];

          "video/mp4" = [ "mpv.desktop" ];
          "video/x-matroska" = [ "mpv.desktop" ];
          "video/webm" = [ "mpv.desktop" ];
          "video/*" = [ "mpv.desktop" ];

          "audio/mpeg" = [ "mpv.desktop" ];
          "audio/ogg" = [ "mpv.desktop" ];
          "audio/wav" = [ "mpv.desktop" ];
          "audio/flac" = [ "mpv.desktop" ];
          "audio/*" = [ "mpv.desktop" ];

          "application/pdf" = [ "zathura.desktop" ];

          "application/zip" = [ "ark.desktop" ];
          "application/x-tar" = [ "ark.desktop" ];
          "application/x-7z-compressed" = [ "ark.desktop" ];
          "application/x-rar" = [ "ark.desktop" ];

          "inode/directory" = [ "dolphin.desktop" ];
        };
      };
    };
  };
}
