{ self, inputs, ... }: {
  flake.nixosModules.nixvim = { pkgs, lib, ... }: {
    imports = [
      inputs.nixvim.nixosModules.nixvim
      ./_plugins/alpha.nix
      ./_plugins/telescope.nix
      ./_options.nix
      ./_highlights.nix
    ];

    programs.nixvim = {
      enable = true;
      colorschemes.oxocarbon.enable = true;
    };
  };
}
