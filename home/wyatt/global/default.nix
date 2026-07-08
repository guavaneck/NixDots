{
  lib,
  config,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.nixvim.homeModules.nixvim
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  programs.home-manager.enable = true;

  home = {
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.05";
  };
}
