{ lib, config, ... }:

{
  options.nvim.enable = lib.mkEnableOption "Enable Neovim configuration via the nvf framework";

  config = lib.mkIf config.nvim.enable {
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };

          options = {
            nu = true;
            relativenumber = true;
            cindent = true;
            cinkeys = "0{,0},0),0],:,!^F,o,O,e";
            tabstop = 2;
            softtabstop = 2;
            shiftwidth = 2;
            expandtab = true;
            hlsearch = false;
            incsearch = true;
            scrolloff = 8;
            showmode = false;
            signcolumn = "yes";
            cmdheight = 0;
            updatetime = 30;
            ignorecase = true;
            smartcase = true;
            wrap = true;
          };

          statusline.lualine.enable = true;
          autocomplete.blink-cmp.enable = true;
          filetree.neo-tree.enable = true;
          treesitter.enable = true;
          telescope.enable = true;
          git.enable = true;

          keymaps = [
            { mode = "n"; key = "<leader>x"; action = ":Neotree filesystem<Enter>"; }
            { mode = "n"; key = "<leader>b"; action = ":Neotree buffers<Enter>"; }
            { mode = "n"; key = "<leader>f"; action = ''
            function()
              require("conform").format({ async = true }, function(err, did_edit)
                if not err and did_edit then
                  vim.notify("Buffer formatted", vim.log.levels.INFO, { title = "Conform" })
                end
              end)
            end, { desc = "Format buffer" })
            '';
            }
            { mode = "v"; key = "J"; action = ">+1<CR>gv=gv"; }
            { mode = "v"; key = "K"; action = ">-2<CR>gv=gv"; }
            { mode = "n"; key = "J"; action = "mzJ`z"; }
            { mode = "n"; key = "n"; action = "nzzzv"; }
            { mode = "n"; key = "N"; action = "Nzzzv"; }
            { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; }
            { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; }
            { mode = "x"; key = "<leader>p"; action = "\\\"_dP"; }
            { mode = "n"; key = "<leader>s"; action = ":vs<Enter>"; }
            { mode = "n"; key = "<leader>h"; action = "<C-w>h"; }
            { mode = "n"; key = "<leader>j"; action = "<C-w>j"; }
            { mode = "n"; key = "<leader>k"; action = "<C-w>k"; }
            { mode = "n"; key = "<leader>l"; action = "<C-w>l"; }
          ];
        };
      };
    };
  };
}
