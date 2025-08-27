{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      notify_on_error = false;
      notify_no_formatters = false;
      format_on_save = { };
      formatters_by_ft = {
        # fallback for unconfigured filetypes
        "_" = [ "trim_whitespace" ];
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
