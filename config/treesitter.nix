{ pkgs, ... }:

{
  withNodeJs = true;

  extraPlugins = with pkgs.vimPlugins; [
    comment-nvim
    nvim-treesitter-context
    nvim-treesitter.withAllGrammars
    nvim-ts-context-commentstring
    # nvim-ts-autotag
    # ts-comments
  ];

  extraConfigLua = # lua
    ''
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
      require('ts_context_commentstring').setup{
        enable_autocmd = false,
      }
      vim.g.skip_ts_context_commentstring_module = true;

      require'treesitter-context'.setup{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
      }

      require'Comment'.setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    '';
}
