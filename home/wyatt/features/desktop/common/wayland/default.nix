{ pkgs, ... }: {
  imports = [
    ./kitty.nix

  ];

  home.packages = with pkgs; [
    wf-recorder
    wl-clipboard
  ];
}
