{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    eza
    nh
  ];
}
