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

  home = {
    username = "rokakaka";

    packages = with pkgs; [
      # ...
    ];  
  };
}
