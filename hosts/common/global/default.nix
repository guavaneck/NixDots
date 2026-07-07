{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./nix.nix
      ./fish.nix
      ./tailscale.nix
      ./pipewire.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
}
