{ config, ... }: let
  colors = config.colorScheme;
in {
  programs.kitty = {
    enable = true;
    settings = {
      # Font
      font_family = config.fontProfiles.monospace.name;
      font_size = config.fontProfiles.monospace.size;

      # Window
      background_opacity = "0.80";
      confirm_os_window_close = 0;

      # Colors
      background = colors.background;
      foreground = colors.foreground;

      cursor = colors.cursor;
      cursor_text_color = colors.cursorText;

      # Black
      color0 = colors.black;
      color8 = colors.brightBlack;
      # Red
      color1 = colors.red;
      color9 = colors.brightRed;
      # Green
      color2 = colors.green;
      color10 = colors.brightGreen;
      # Yellow
      color3 = colors.yellow;
      color11 = colors.brightYellow;
      # Blue
      color4 = colors.blue;
      color12 = colors.brightBlue;
      # Magenta
      color5 = colors.magenta;
      color13 = colors.brightMagenta;
      # Cyan
      color6 = colors.cyan;
      color14 = colors.brightCyan;
      # White
      color7 = colors.white;
      color15 = colors.brightWhite;
    };
  };
}
