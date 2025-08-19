{ pkgs, ... }:

{
  package = pkgs.neovim-unwrapped;
  viAlias = true;
  vimAlias = true;

  opts = {
    shell = "${pkgs.bashInteractive}/bin/bash";
    background = "dark";
    hidden = true;
    showtabline = 0;
    mouse = "a";
    autowrite = true;
    expandtab = true;
    foldcolumn = "0";
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    showmatch = true;
    softtabstop = 4;
    spell = true;
    spelllang = "en_us";
    wildmenu = true;
    laststatus = 3;
    modeline = false;
    showmode = false;
    ruler = true;
    showcmd = true;
    ignorecase = true;
    smartcase = true;
    swapfile = false;
    backup = false;
    completeopt = [
      "menuone"
      "noselect"
    ];
  };

  globals.mapleader = ",";

  extraPackages = with pkgs; [
    bat
    fd
    ripgrep
  ];

  editorconfig.enable = true;

  plugins = {
    barbar = {
      enable = true;
      settings = {
        auto_hide = 1;
        icons = {
          button = false;
          buffer_index = true;
          separator = {
            left = " ";
          };
          inactive = {
            separator = {
              left = " ";
            };
          };
          filetype = {
            enabled = false;
          };
        };
        tabpages = false;
        animation = false;
        # add_in_buffer_number_order = true;
      };
      luaConfig.pre = # lua
        ''
          local silent = { noremap=true, silent=true }
          vim.api.nvim_set_keymap('n', '<Leader>1', ':BufferGoto 1<CR>', silent)
          vim.api.nvim_set_keymap('n', '<Leader>2', ':BufferGoto 2<CR>', silent)
          vim.api.nvim_set_keymap('n', '<Leader>3', ':BufferGoto 3<CR>', silent)
          vim.api.nvim_set_keymap('n', '<Leader>4', ':BufferGoto 4<CR>', silent)
          vim.api.nvim_set_keymap('n', '<Leader>5', ':BufferGoto 5<CR>', silent)
          vim.api.nvim_set_keymap('n', '<Leader>6', ':BufferGoto 6<CR>', silent)
          vim.api.nvim_set_keymap('n', '<Leader>7', ':BufferGoto 7<CR>', silent)
          vim.api.nvim_set_keymap('n', '<Leader>8', ':BufferGoto 8<CR>', silent)
          vim.api.nvim_set_keymap('n', '<Leader>9', ':BufferGoto 9<CR>', silent)
          vim.api.nvim_set_keymap('n', '<Leader>0', ':BufferGoto 10<CR>', silent)
        '';
    };
    conform-nvim = {
      enable = true;
      settings = { }; # TODO
    };
    direnv = {
      enable = true;
    };
    gitsigns = {
      enable = true;
      settings = {
        linehl = false;
        numhl = true;
        signcolumn = false;
      };
    };
    indent-blankline = {
      enable = true;
      luaConfig.post = # lua
        ''
          -- if guifg is not specified, ctermfg gets overwritten
          vim.cmd [[hi IndentBlanklineChar guifg='Blue' ctermfg=4]]
        '';
    };
    lastplace.enable = true;
    # lint.enable = true;
    lualine = {
      enable = true;
      settings.options = {
        section_separators = " ";
        component_separators = "|";
      };
    };
    luasnip.enable = true;
    neoscroll = {
      enable = true;
      settings.mappings = [
        "<C-y>"
        "<C-e>"
      ];
      luaConfig.pre = # lua
        ''
          local silent = { noremap=true, silent=true }
          vim.keymap.set({"", '!'}, '<ScrollWheelUp', '<C-y>', silent)  
          vim.keymap.set({"", '!'}, '<ScrollWheelDown>', '<C-e>', silent)    
        '';
    };
    # noice.enable = true;
    oil.enable = true;
    telescope = {
      enable = true;
      luaConfig.post = # lua
        ''
          local noremap = { noremap=true }
          vim.api.nvim_set_keymap('n', '<c-p>', '<cmd>Telescope find_files no_ignore=true<CR>', noremap)
          vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', noremap)
          vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>', noremap)
          vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>Telescope buffers<CR>', noremap)
          vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>', noremap)
        '';
    };
    todo-comments = {
      enable = true;
      settings = {
        signs = false;
        highlight = {
          before = "fg";
          keyword = "fg";
          after = "fg";
        };
      };
      luaConfig.post = # lua
        ''
          -- todo-comments does not natively support cterm colors
          vim.cmd [[ 
            hi Todo ctermbg=NONE
            hi TodoFgTODO ctermbg=NONE ctermfg=5 cterm=BOLD
            hi TodoFgHACK ctermbg=NONE ctermfg=1 cterm=BOLD
            hi TodoFgWARN ctermbg=NONE ctermfg=1 cterm=BOLD
            hi TodoFgPERF ctermbg=NONE ctermfg=2 cterm=BOLD
            hi TodoFgNOTE ctermbg=NONE ctermfg=7 cterm=BOLD
            hi TodoFgTEST ctermbg=NONE ctermfg=6 cterm=BOLD
          ]]
        '';
    };
    vim-suda = {
      enable = true;
      settings.smart_edit = 1;
    };
    which-key = {
      enable = true;
    };
  };

  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      icons = { };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    readline-vim
    vim-eunuch
  ];

  extraConfigLua =
    # lua
    ''
      vim.cmd.syntax('on')

      vim.cmd [[
        "Italics support
        hi Comment cterm=italic
        let &t_ZH="\e[3m"
        let &t_ZR="\e[23m"

        hi LineNr ctermbg=None
        hi Normal ctermbg=None

        hi SpellBad ctermbg=None
        hi FoldColumn ctermbg=None
      ]]

      local noremap = { noremap=true }
      local silent = { noremap=true, silent=true }
      local expr = { noremap=true, silent=true, expr=true }

      vim.api.nvim_set_keymap('n', ';', ':', noremap)
      vim.api.nvim_set_keymap('v', ';', ':', noremap)

      -- Visual Line movements
      vim.api.nvim_set_keymap("", 'j', "(v:count == 0 ? 'gj' : 'j')", expr)
      vim.api.nvim_set_keymap("", 'k', "(v:count == 0 ? 'gk' : 'k')", expr)

      -- Keep text selected when fixing indentation
      vim.api.nvim_set_keymap('v', '<', '<gv', noremap)
      vim.api.nvim_set_keymap('v', '>', '>gv', noremap)
    '';
}
