{ pkgs, config, ... }: {
  imports = [
    ./discord.nix
    ./dragon.nix
    ./firefox.nix
    ./font.nix
  ];

  home.packages = [
    pkgs.mako
  ];
}
