{ pkgs, config, ... }: {
  
  imports = [
    ./steam.nix
    ./osu.nix
  ];
}
