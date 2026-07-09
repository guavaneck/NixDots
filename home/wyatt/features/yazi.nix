{ pkgs, config, ... }: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

    settings = {
      mgr = {
        ratio = [1 3 4];
        show-hidden = false;
        show-symlink = true;
      };

      preview = {
        max-width = 1000;
        max-height = 1000;
      };

      opener = {
        edit = [{run = ''nvim "$@"''; block = true;}];
        open = [{run = ''xdg-open "$@"'';}];
        reveal = [{run = ''xdg-open "$(dirname "$0")"'';}];
      };

      open = {
        rules = [
          {mime = "inode/empty"; use = "edit";}
          {mime = "text/*"; use = "edit";}
          {mime = "application/*"; use = "open";}
          {mime = "image/*"; use = "open";}
          {mime = "video/*"; use = "open";}
          {mime = "audio/*"; use = "open";}
        ];
      };
    };
  };
  # ----- make yazi the default file manager -----
  # yazi is a TUI, so "default" means: register a .desktop entry that
  # launches a terminal running yazi, then point inode/directory at it
  xdg.enable = true; 
  xdg.desktopEntries.yazi = {
    name = "Yazi";
    genericName = "File Manager";
    comment = "Terminal file manager";
    exec = "${pkgs.kitty}/bin/kitty --title yazi -e ${pkgs.yazi}/bin/yazi %U";
    icon = "yazi";
    terminal = false;
    type = "Application";
    categories = ["System" "FileManager"];
    mimeType = ["inode/directory"];
  };

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "yazi.desktop";
  };
}
