{lib, ...}: let
  mkColorOption = name:
    lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "Hex value for the '${name}' color";
      example = "#8c8882";
    };
in {
  options.colorScheme = {
    background = mkColorOption "background";
    foreground = mkColorOption "foreground";
    cursor = mkColorOption "cursor";
    cursorText = mkColorOption "cursorText";

    # accent is used for highlights that aren't part of the base 16-color palette
    accent = mkColorOption "accent";

    black = mkColorOption "black";
    red = mkColorOption "red";
    green = mkColorOption "green";
    yellow = mkColorOption "yellow";
    blue = mkColorOption "blue";
    magenta = mkColorOption "magenta";
    cyan = mkColorOption "cyan";
    white = mkColorOption "white";

    brightBlack = mkColorOption "brightBlack";
    brightRed = mkColorOption "brightRed";
    brightGreen = mkColorOption "brightGreen";
    brightYellow = mkColorOption "brightYellow";
    brightBlue = mkColorOption "brightBlue";
    brightMagenta = mkColorOption "brightMagenta";
    brightCyan = mkColorOption "brightCyan";
    brightWhite = mkColorOption "brightWhite";
  };
}
