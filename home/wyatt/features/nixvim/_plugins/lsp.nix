{
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;
      settings = {
        keymap.preset = "default";
        completion = {
          documentation.auto_show = true;
          menu.auto_show = true;
        };
        signature.enabled = true;
        sources.default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
      };
    };

    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        gdscript = {
          enable = true;
          package = null;
        };
        lua_ls.enable = true;
        basedpyright.enable = true;
        clangd.enable = true;
        ts_ls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        gopls.enable = true;
        bashls.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        html.enable = true;
        cssls.enable = true;
        marksman.enable = true;
      };
    };
  };
}
