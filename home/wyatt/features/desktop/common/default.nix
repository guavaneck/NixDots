{ pkgs, config, ... }: {
  imports = [
    ./discord.nix
    ./dragon.nix
    ./firefox.nix
    ./font.nix
    ./wayland
  ];

  home.packages = [
    pkgs.mako
  ];
}
