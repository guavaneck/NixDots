{ pkgs, config, ... }: {
  imports = [
    ./discord.nix
    ./dragon.nix
    ./firefox.nix
    ./font.nix
    ./wayland
    ./theme.nix
  ];

  home.packages = [
    pkgs.mako
  ];
}
