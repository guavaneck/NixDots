{
  programs.nixvim.plugins.alpha = {
    enable = true;
    settings.layout = [
      # padding   
      {
        type = "padding";
        val = 4;
      }

      # header
      {
        type = "text";
        val = [
          " ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓   "
          " ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒   "
          "▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░   "
          "▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██    "
          "▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒   "
          "░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░   "
          "░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░   "
          "   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░      "
          "         ░    ░  ░    ░ ░        ░   ░         ░      "
          "                                ░                     "
        ];
        opts = {
          position = "center";
          hl = "AlphaHeader";
        };
      }

      # padding
      {
        type = "padding";
        val = 2;
      }

      # buttons
      {
        type = "group";
        val = [
          {
            type = "button";
            val = "  Find File";
            on_press.__raw = "function() vim.cmd('Telescope find_files') end";
            opts = {
              shortcut = "f";
              keymap.__raw = ''{"n", "f", ":Telescope find_files<CR>", { noremap = true, silent = true, nowait = true }}'';
              position = "center";
              cursor = 3;
              width = 38;
              align_shortcut = "right";
              hl_shortcut = "AlphaShortcut";
            };
          }
          {
            type = "button";
            val = "  Recent Files";
            on_press.__raw = "function() vim.cmd('Telescope oldfiles') end";
            opts = {
              shortcut = "r";
              keymap.__raw = ''{"n", "r", ":Telescope oldfiles<CR>", { noremap = true, silent = true, nowait = true }}'';
              position = "center";
              cursor = 3;
              width = 38;
              align_shortcut = "right";
              hl_shortcut = "AlphaShortcut";
            };
          }
          {
            type = "button";
            val = "  New File";
            on_press.__raw = "function() vim.cmd('enew') end";
            opts = {
              shortcut = "n";
              keymap.__raw = ''{"n", "n", ":enew<CR>", { noremap = true, silent = true, nowait = true }}'';
              position = "center";
              cursor = 3;
              width = 38;
              align_shortcut = "right";
              hl_shortcut = "AlphaShortcut";
            };
          }
          {
            type = "button";
            val = "  Quit";
            on_press.__raw = "function() vim.cmd('qa') end";
            opts = {
              shortcut = "q";
              keymap.__raw = ''{"n", "q", ":qa<CR>", { noremap = true, silent = true, nowait = true }}'';
              position = "center";
              cursor = 3;
              width = 38;
              align_shortcut = "right";
              hl_shortcut = "AlphaShortcut";
            };
          }
        ];
        opts.spacing = 1;
      }

      # footer
      {
        type = "padding";
        val = 2;
      }
      {
        type = "text";
        val = "guava";
        opts = {
          position = "center";
          hl = "AlphaFooter";
        };
      }
    ];
  };
}
