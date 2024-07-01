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
			symbola
			(nerdfonts.override { fonts = [ "Cousine" "InconsolataLGC" "Iosevka" "JetBrainsMono" "Noto" "Tinos" ]; })
		];

		fontconfig = {
			defaultFonts = {
				serif = [ "Tinos Nerd Font" "Liberation Serif" ];
				sansSerif = [ "Noto Nerd Font" "Liberation Sans" ];
				monospace = [ "Iosevka Nerd Font" ];
				emoji = [ "Noto Color Emoji" ];
			};
		};
	};
}
