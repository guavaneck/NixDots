{
  inputs,
  outputs,
  ...
}: {
  imports = [
      inputs.home-manager.nixosModules.home-manager
      ./nix.nix
      ./tailscale.nix

  ];
   
  programs.fish.enable = true;
  programs.dconf.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {inherit inputs outputs;};
  home-manager.backupFileExtension = "backup";

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
}
