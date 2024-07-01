{ pkgs, lib, config, ... }:

{
  imports = [
    ./submodules/archie.nix
    ./submodules/hyprland.nix
    ./submodules/plasma.nix
    ./submodules/zsh.nix
  ];

  archie.enable = true;
  zshConfiguration.enable = true;
  hyprlandDesktop.enable = true;
  plasma.enable = false;
  
	environment = {
		defaultPackages = with pkgs; [ perl rsync ];

		systemPackages = with pkgs; [

			# Programmes
      anytype
			armcord
      bottles
			btop
			electrum
			element-desktop
      (import ./submodules/emacs.nix { inherit pkgs; })
			gimp
			gtypist
			heroic
			iamb
			#imgbrd-grabber
			imv
      kitty
			librewolf
			lmms
			monero-cli
			nomacs
      prismlauncher
			telegram-desktop
			thunderbird
			tor-browser
			transmission_4-gtk
			zathura

			# Utilities
			brightnessctl
			cron
			du-dust
      eww
			glxinfo
      grim
			jc
			jq
      hyprpaper
			kdiskmark
			lsd
			lynx
      mangohud
			mpc-cli
			nitch
			nix-prefetch-git
			nmap
			openvpn
			pandoc
			parallel
			pass-wayland
			p7zip
			qrencode
      rofi-wayland
      rofi-calc
      rofi-emoji
      slurp
			socat
			soundconverter
			smartmontools
			texlive.combined.scheme-full
			unzip
      waybar
			wget
			wineWowPackages.waylandFull

			libimobiledevice
			ifuse
		];

		variables = {
			EDITOR = "nvim";
			VISUAL = "nvim";
		};
	};

	programs = {
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryPackage = lib.mkForce pkgs.pinentry-curses;
		};

		neovim = {
			enable = true;
			vimAlias = true;
			defaultEditor = true;
		};

    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 5";
      };
    };

		steam = {
			enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
		};

    gamemode = {
      enable = true;
      settings = {
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode stopped'";
        };
      };
    };

		git = {
			enable = true;
		};
	};

	services = {
		btrfs = {
			autoScrub = {
				enable = true;
				interval = "weekly";
			};
		};

		pipewire = {
			enable = true;
			alsa.enable = true;
			pulse.enable = true;

			wireplumber = {
				enable = true;
			};
		};

		udisks2.enable = true;

		usbmuxd = {
			enable = true;
			package = pkgs.usbmuxd2;
		};
	};
}
