{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.linker.enable = lib.mkEnableOption "Enable dynamic linker";

  config = lib.mkIf config.linker.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Basic runtime
        stdenv.cc.cc
        zlib
        zstd
        openssl
        curl

        # Common system libraries
        glib
        dbus
        systemd
        libcap
        libuuid
        libxml2

        # X11
        libX11
        libXext
        libXrender
        libXfixes
        libXrandr
        libXi
        libXcursor
        libXcomposite
        libXdamage
        libXtst
        libxcb

        # Wayland
        wayland
        libxkbcommon

        # Graphics
        libGL
        libglvnd
        vulkan-loader

        # Fonts / rendering
        fontconfig
        freetype
        expat

        # Audio
        alsa-lib
        libpulseaudio

        # GUI applications
        gtk3
        pango
        cairo
        gdk-pixbuf
        atk
        at-spi2-atk
        at-spi2-core
      ];
    };
  };
}
