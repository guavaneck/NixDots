{lib, ...}: {
  options.wallpaper = lib.mkOption {
    type = lib.types.nullOr lib.types.path;
    default = null;
    description = "Wallpaper image, typically pkgs.wallpapers.<name>";
  };
}
