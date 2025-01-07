{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      baekmuk-ttf
      font-awesome
      liberation_ttf
      ipafont
      nika-fonts
      noto-fonts-emoji
      paratype-pt-sans
      paratype-pt-serif
      tibetan-machine
      #symbola
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
