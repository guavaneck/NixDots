{pkgs, ...}: {
  imports = [
    ./global
    ./colorschemes/guava.nix
    ./features/desktop/swayfx
    ./features/desktop/common
    ./features/cli
    ./features/nixvim
    ./features/yazi.nix
    ./features/wallpaper.nix
    ./features/games  
    ];
  
  wallpaper = pkgs.wallpapers.black;
  output = "DP-1";
  display = "2560x1440@180.002Hz";
  home = {
    username = "rokakaka";

    packages = with pkgs; [
      # ...
    ];  
  };
}
