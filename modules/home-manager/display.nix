{lib, ...}: {
  options.output = lib.mkOption {
    type = lib.types.str;
    default = "eDP-1";
    description = "Sway output config line, e.g. \"DP-1\"";
  };
  options.display = lib.mkOption {
    type = lib.types.str;
    default = "920x1080@60Hz";
    description = "Sway resolution config line, e.g. \"2880x1800@120Hz\"";
  };
}
