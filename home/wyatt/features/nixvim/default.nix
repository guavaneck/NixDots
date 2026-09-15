{pkgs, ...}: {
  imports = [
    ./_plugins/alpha.nix
    ./_plugins/telescope.nix
    ./_plugins/yazi.nix
    ./_plugins/fugitive.nix
    ./_plugins/mini.nix
    ./_plugins/parinfer.nix
    ./_plugins/lsp.nix
    ./_plugins/godot.nix
    ./_options.nix
    ./_highlights.nix
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs.source = pkgs.path;

    opts.termguicolors = true;

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "latte";
        transparent_background = true;
      };
    };

    plugins.treesitter = {
      enable = true;
      highlight.enable = true;
    };
  };
}
