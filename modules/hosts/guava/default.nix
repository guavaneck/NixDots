{ self, inputs, ... }: {

  flake.nixosConfigurations.guava = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.guavaConfiguration
    ];
  };

}
