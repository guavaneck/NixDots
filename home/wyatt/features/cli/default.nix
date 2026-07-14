{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    dosfstools
    gparted
    fd
    bat
    eza
    nh
    zip
    freshfetch
  ];
}
