{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options.nixvimConfig.enable = lib.mkEnableOption "Enable Nixvim configuration";

  config = lib.mkIf config.nixvimConfig.enable {

    programs.nixvim = {
      enable = true;
      enableMan = false;
      vimAlias = true;
      extraLuaPackages = luaPkgs: with luaPkgs; [lua-utils-nvim nvim-nio pathlib-nvim];

      colorschemes.catppuccin.enable = true;

      clipboard.register = "unnamedplus";

      plugins = {
        lualine.enable = true;

        web-devicons.enable = true;

        treesitter = {
          enable = true;
        };

        nvim-tree = {
          enable = true;
          autoClose = false;
          disableNetrw = true;
        };
        
        headlines = {
          enable = true;
        };

        neorg = {
          enable = true;

          modules = {
            "core.defaults" = {
              __empty = null;
            };

            "core.dirman" = {
              config = {
                workspaces = {
                  domestic = "~/notes/domestic";
                  games = "~/notes/games";
                  production = "~/notes/production";
                };
              };
            };

            "core.concealer" = {
              config = {
                icon_preset = "varied";
              };
            };
          };
        };
      };

      globals = {
        mapleader = " ";
        maplocalleader = "`";
      };
      opts = {
        relativenumber = true;
        number = true;
        splitbelow = true;
        splitright = true;
        swapfile = false;
        ignorecase = true;
        smartcase = true;
        scrolloff = 8;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        autoindent = true;
      };

      keymaps = [
        {
          action = "<cmd>NvimTreeToggle<CR>";
          key = "<leader>x";
        }

        {
          action = "<cmd>vs<CR>";
          key = "<leader>s";
        }

        {
          action = "<C-w>h";
          key = "<leader>h";
        }
        {
          action = "<C-w>j";
          key = "<leader>j";
        }
        {
          action = "<C-w>k";
          key = "<leader>k";
        }
        {
          action = "<C-w>l";
          key = "<leader>l";
        }

        {
          key = "<C-Up>";
          action = ":resize -2<CR>";
        }
        {
          key = "<C-Down>";
          action = ":resize +2<CR>";
        }
        {
          key = "<C-Left>";
          action = ":vertical resize +2<CR>";
        }
        {
          key = "<C-Right>";
          action = ":vertical resize -2<CR>";
        }
      ];
    };
  };
}
