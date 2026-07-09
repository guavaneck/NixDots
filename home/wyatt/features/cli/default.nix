{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./fastfetch.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    eza
    nh
    zip
  ];
}
