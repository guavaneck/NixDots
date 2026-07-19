{pkgs, ...}: {
  imports = [
    ./_plugins/alpha.nix
    ./_plugins/telescope.nix
    ./_plugins/yazi.nix
    ./_plugins/fugitive.nix
    ./_options.nix
    ./_highlights.nix
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs.source = pkgs.path;

   opts.termguicolors = false; 
  };
}
