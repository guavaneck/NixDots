{ config, ... }: {
  programs.kitty = {
    enable = true;
    settings = {
      font_family = config.fontProfiles.monospace.name; 
      font_size = config.fontProfiles.monospace.size;
      background_opacity = "0.95";
      confirm_os_window_close = 0;
    };
  };
}
