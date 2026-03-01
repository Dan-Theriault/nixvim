{
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "default";
      sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
          "git"
        ];
        providers = {
          git = {
            module = "blink-cmp-git";
            name = "git";
            score_offset = 100;
            opts = {
              commit = { };
              git_centers = {
                git_hub = { };
              };
            };
          };
        };
      };
      snippets.preset = "luasnip";
      fuzzy.implementation = "lua";
      signature.enabled = true;
    };
  };
  plugins.blink-cmp-git.enable = true;
}
