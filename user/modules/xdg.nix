{
  lib,
  config,
  ...
}: {
  options.xdgConfig.enable = lib.mkEnableOption "Configure XDG home directories & stuff";

  config = lib.mkIf config.xdgConfig.enable {
    xdg = {
      cacheHome = "${config.xdg.dataHome}/cache";
      userDirs = {
        setSessionVariables = true;

        enable = true;
        createDirectories = true;
        desktop = "${config.xdg.dataHome}/desktop";
        publicShare = null;
        templates = null;
        projects = "${config.home.homeDirectory}/build";
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        music = "${config.home.homeDirectory}/music";
        pictures = "${config.home.homeDirectory}/pictures";
        videos = "${config.home.homeDirectory}/videos";
      };

      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = ["librewolf.desktop"];
          "x-scheme-handler/http" = ["librewolf.desktop"];
          "x-scheme-handler/https" = ["librewolf.desktop"];

          "text/plain" = ["emacs.desktop"];
          "application/json" = ["emacs.desktop"];
          "application/xml" = ["emacs.desktop"];
          "text/xml" = ["emacs.desktop"];

          "image/png" = ["imv.desktop"];
          "image/jpeg" = ["imv.desktop"];
          "image/gif" = ["imv.desktop"];
          "image/webp" = ["imv.desktop"];
          "image/*" = ["imv.desktop"];

          "video/mp4" = ["mpv.desktop"];
          "video/x-matroska" = ["mpv.desktop"];
          "video/webm" = ["mpv.desktop"];
          "video/*" = ["mpv.desktop"];

          "audio/mpeg" = ["mpv.desktop"];
          "audio/ogg" = ["mpv.desktop"];
          "audio/wav" = ["mpv.desktop"];
          "audio/flac" = ["mpv.desktop"];
          "audio/*" = ["mpv.desktop"];

          "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];

          "application/zip" = ["dev.duxlabs.files.desktop"];
          "application/x-tar" = ["dev.duxlabs.files.desktop"];
          "application/x-7z-compressed" = ["dev.duxlabs.files.desktop"];
          "application/x-rar" = ["dev.duxlabs.files.desktop"];

          "inode/directory" = ["dev.duxlabs.files.desktop"];
        };
      };
    };
  };
}
