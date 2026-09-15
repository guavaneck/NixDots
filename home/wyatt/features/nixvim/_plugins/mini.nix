{
  programs.nixvim.plugins.mini-pairs = {
    enable = true;
    settings = {
      modes = {
        insert = true;
        command = true;
        terminal = false;
      };
    };
  };

  programs.nixvim.plugins.mini-icons = {
    enable = true;
    settings = {
      style = "glyph";
    };
  };
}
