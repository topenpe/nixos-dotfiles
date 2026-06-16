{
  pkgs,
  ...
}:

{ # Add more fonts here if needed:
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      baekmuk-ttf
      dejavu_fonts
      font-awesome
      liberation_ttf
      ipafont
      nika-fonts
      noto-fonts-color-emoji
      paratype-pt-sans
      paratype-pt-serif
			terminus_font
      tibetan-machine
			unifont
      nerd-fonts.cousine
      nerd-fonts.inconsolata-lgc
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
      nerd-fonts.tinos
    ];

    fontconfig = {
      defaultFonts = {
        serif = [
          "Tinos Nerd Font"
          "Liberation Serif"
        ];
        sansSerif = [
          "Noto Nerd Font"
          "Liberation Sans"
        ];
        monospace = [ "Iosevka Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
