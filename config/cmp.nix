_:

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
        ];
      };
      snippets.preset = "luasnip";
      fuzzy.implementation = "lua";
      signature.enabled = true;
    };
  };
}
