{ pkgs, config, ... }: {
  
  imports = [
    ./deadlock.nix
    ./osu.nix
  ];
}
