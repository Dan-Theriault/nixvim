{
  plugins.lint = {
    enable = true;

    # NOTE: Enabling these will cause errors unless these tools are installed
    lintersByFt = {
      nix = [
        "nix"
        "statix"
      ];
      bash = [ "shellcheck" ];
      sh = [ "shellcheck" ];
      fish = [ "shellcheck" ];
      c = [ "clangtidy" ];
      h = [ "clangtidy" ];
      cpp = [ "clangtidy" ];
      hpp = [ "clangtidy" ];
    };

    # Create autocommand which carries out the actual linting
    # on the specified events.
    autoCmd = {
      callback.__raw = ''
        function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            require('lint').try_lint()
          end
        end
      '';
      group = "lint";
      event = [
        "BufEnter"
        "BufWritePost"
        "InsertLeave"
      ];
    };
  };

  autoGroups = {
    lint = {
      clear = true;
    };
  };
}
