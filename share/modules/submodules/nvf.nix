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

          lsp = {
            enable = true;
          };

          languages = {
            assembly = { enable = true; treesitter.enable = true; lsp.enable = true; };
            bash = { enable = true; treesitter.enable = true; format.enable = true; lsp.enable = true; };
            clojure = { enable = true; treesitter.enable = true; lsp.enable = true; };
            csharp = { enable = true; treesitter.enable = true; lsp.enable = true; };
            css = { enable = true; treesitter.enable = true; format.enable = true; format.type = [ "biome" ]; lsp.enable = true; };
            go = { enable = true; treesitter.enable = true; format.enable = true; format.type = [ "gofmt" ]; lsp.enable = true; };
            haskell = { enable = true; treesitter.enable = true; lsp.enable = true; };
            html = { enable = true; treesitter.enable = true; format.enable = true; lsp.enable = true; };
            java = { enable = true; treesitter.enable = true; lsp.enable = true; };
            json = { enable = true; treesitter.enable = true; format.enable = true; lsp.enable = true; };
            just = { enable = true; treesitter.enable = true; lsp.enable = true; };
            kotlin = { enable = true; treesitter.enable = true; lsp.enable = true; };
            lua = { enable = true; treesitter.enable = true; format.enable = true; lsp.enable = true; };
            markdown = { enable = true; treesitter.enable = true; format.enable = true; lsp.enable = true; extensions.markview-nvim.enable = true; };
            nix = { enable = true; treesitter.enable = true; format.enable = true; format.type = [ "nixfmt" ]; lsp.enable = true; };
            nu = { enable = true; treesitter.enable = true; lsp.enable = true; };
            python = { enable = true; treesitter.enable = true; format.enable = true; format.type = [ "isort" "black" ]; lsp.enable = true; };
            r = { enable = true; treesitter.enable = true; format.enable = true; format.type = [ "styler" ]; lsp.enable = true; };
            rust = { enable = true; treesitter.enable = true; format.enable = true; lsp.enable = true; extensions.crates-nvim.enable = true; };
            sql = { enable = true; treesitter.enable = true; format.enable = true; lsp.enable = true; };
            typescript = { enable = true; treesitter.enable = true; format.enable = true; format.type = [ "biome" ]; lsp.enable = true; };
            yaml = { enable = true; treesitter.enable = true; lsp.enable = true; };
            zig = { enable = true; treesitter.enable = true; lsp.enable = true; };
          };

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
