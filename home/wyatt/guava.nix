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
    ];
  
  wallpaper = pkgs.wallpapers.black; 
  display = "1920x1080@60Hz";
  home = {
    username = "guava";

    packages = with pkgs; [
      # ...
    ];  
  };
}
