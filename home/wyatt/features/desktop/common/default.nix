{ pkgs, config, ... }: {
  imports = [
    ./discord.nix
    ./dragon.nix
    ./firefox.nix
    ./font.nix
    ./wayland
    ./theme.nix
    ./phone-mic.nix
  ];

  home.packages = [
    pkgs.mako
  ];
}
