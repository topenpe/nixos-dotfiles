{ lib, config, ... }:

{
  options.nixvimConfig.enable = lib.mkEnableOption "Enable Nixvim configuration";

  config = lib.mkIf config.nixvimConfig.enable {
    programs.nixvim = {
      enable = true;
      enableMan = false;
      colorscheme = "catppuccin-mocha";
      clipboard.register = "unnamedplus";

      global = {
        mapleader = " ";
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

      keymaps = {
        normal =
          lib.mapAttrsToList
            (key: action: {
              mode = "n";
              inherit action key;
            })
            {
              "<leader>n" = "Neotree<CR>";
              "<C-c>" = "b<CR>";

              "<leader>h" = "<C-w>h";
              "<leader>j" = "<C-w>j";
              "<leader>k" = "<C-w>k";
              "<leader>l" = "<C-w>l";

              "<C-Up>" = ":resize -2<CR>";
              "<C-Down>" = ":resize +2<CR>";
              "<C-Left>" = ":vertical resize +2<CR>";
              "<C-Right>" = ":vertical resize -2<CR>";

              "M-k" = ":move-2<CR>";
              "M-j" = ":move+2<CR>";
            };

        visual = lib.mapAttrsToList (key: action: {
          mode = "v";
          inherit action key;
        }) { };
      };
    };
  };
}
