{pkgs, ...}: {
  imports = [
    ./global
    ./features/desktop/swayfx
    ./features/desktop/common
    ./features/cli
    ./features/nixvim
    ./features/yazi.nix
    ./features/wallpaper.nix
  ];
  
  wallpaper = pkgs.wallpapers.black; 

  home = {
    username = "guava";

    packages = with pkgs; [
      # ...
    ];  
  };
}
