{ pkgs, lib, ... }:

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
      keymaps =
        let
          upTo = x: if x == 0 then [ ] else [ (toString x) ] ++ (upTo (x - 1));
          f = x: {
            name = "goTo${x}";
            value = g x;
          };
          g = x: {
            key = "<Leader>${x}";
            options.silent = true;
          };
        in
        lib.listToAttrs (map f (upTo 9));
    };
    # conform-nvim.enable = true;
    direnv.enable = true;
    gitsigns = {
      enable = true;
      settings = {
        linehl = false;
        numhl = true;
        signcolumn = false;
      };
    };
    indent-blankline.enable = true;
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
    };
    # noice.enable = true;
    oil.enable = true;
    project-nvim = {
      enable = true;
      settings = {
        show_hidden = true;
        # silent_chdir = false;
      };
    };
    telescope.enable = true;
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
    };
    vim-suda = {
      enable = true;
      settings.smart_edit = 1;
    };
    which-key.enable = true;
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

  keymaps = [
    {
      key = ";";
      action = ":";
    }

    # Visual line movements
    {
      key = "j";
      action = "(v:count == 0 ? 'gj' : 'j')";
      options = {
        silent = true;
        expr = true;
      };
    }
    {
      key = "k";
      action = "(v:count == 0 ? 'gk' : 'k')";
      options = {
        silent = true;
        expr = true;
      };
    }

    # Keep text selected when fixing indentation
    {
      mode = "v";
      key = "<";
      action = "<gv";
      options.silent = true;
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
      options.silent = true;
    }

    # For NeoScroll
    {
      mode = [
        ""
        "!"
      ];
      key = "<ScrollWheelUp";
      action = "<C-y>";
      options.silent = true;
    }
    {
      mode = [
        ""
        "!"
      ];
      key = "<ScrollWheelDown";
      action = "<C-e>";
      options.silent = true;
    }

    # Telescope
    {
      mode = "n";
      key = "<c-p>";
      action = "<cmd>Telescope find_files no_ignore=true<CR>";
    }
    {
      mode = "n";
      key = "<Leader>ff";
      action = "<cmd>Telescope find_files<CR>";
    }
    {
      mode = "n";
      key = "<Leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
    }
    {
      mode = "n";
      key = "<Leader>fb";
      action = "<cmd>Telescope buffers<CR>";
    }
    {
      mode = "n";
      key = "<Leader>fh";
      action = "<cmd>Telescope help_tags<CR>";
    }
  ];

  extraConfigLua =
    # lua
    ''
      vim.cmd [[
        "Italics support
        hi Comment cterm=italic
        let &t_ZH="\e[3m"
        let &t_ZR="\e[23m"
      ]]
    '';
}
