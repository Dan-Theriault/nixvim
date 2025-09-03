{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      notify_on_error = false;
      notify_no_formatters = false;
      format_on_save = { };
      formatters_by_ft = {
        "c" = [ "clang-format" ];
        "h" = [ "clang-format" ];
        "cpp" = [ "clang-format" ];
        "hpp" = [ "clang-format" ];
        # "lua" = [ "stylua" ];
        # "nix" = [ "nixfmt" ];
        # fallback for unconfigured filetypes
        "_" = [
          "trim_whitespace"
          "treefmt"
        ];
      };
    };
  };

  keymaps = [
    {
      mode = "";
      key = "<leader>f";
      action.__raw = ''
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end
      '';
      options = {
        desc = "[F]ormat buffer";
      };
    }
  ];
}
