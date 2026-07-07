{
  config,
  pkgs,
  lib,
  ...
}: {
  users.mutableUsers = true;
  users.users.guava = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel" "video" "audio" "docker" "networkmanager"];
  };

  # picks the right home-manager config by hostname
  home-manager.users.guava = import ../../../../home/wyatt/${config.networking.hostName}.nix;
}
