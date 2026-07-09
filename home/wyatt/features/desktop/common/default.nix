{ pkgs, config, ... }: {
  imports = [
    ./discord.nix
    ./dragon.nix
    ./firefox.nix
    ./font.nix
    ./wayland
    ./theme.nix
    ./colors.nix
  ];

  home.packages = [
    pkgs.mako
  ];
}
