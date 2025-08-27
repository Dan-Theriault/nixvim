{
  withNodeJs = true;

  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
      };
    };
    ts-context-commentstring = {
      enable = true;
      extraOptions = {
        enable_autocmd = false;
      };
    };
    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 0;
        min_window_height = 0;
        line_numbers = true;
        multiline_threshold = 20;
        trim_scope = "outer";
        mode = "cursor";
        separator = "-";
        zindex = 20;
      };
    };
    ts-autotag = {
      enable = true;
    };
  };
  extraConfigLua = # lua
    ''
      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring"
          and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    '';
}
