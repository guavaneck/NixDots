{
  programs.nixvim.highlight = {
    AlphaHeader.link = "Title";
    AlphaButtons.link = "Keyword";
    AlphaShortcut.link = "Type";
    AlphaFooter.link = "Comment";

    Normal.bg = "NONE";
    NormalNC.bg = "NONE";
    NormalFloat.bg = "NONE";
    SignColumn.bg = "NONE";
    EndOfBuffer.bg = "NONE";
  };

  # Catppuccin's Telescope integration sets Latte surface backgrounds after
  # the base highlights load. Override them last so Kitty remains visible.
  programs.nixvim.highlightOverride = {
    Normal.bg = "NONE";
    NormalNC.bg = "NONE";
    NormalFloat.bg = "NONE";
    FloatBorder.bg = "NONE";
    SignColumn.bg = "NONE";
    EndOfBuffer.bg = "NONE";

    TelescopeNormal.bg = "NONE";
    TelescopeBorder.bg = "NONE";
    TelescopePromptNormal.bg = "NONE";
    TelescopePromptBorder.bg = "NONE";
    TelescopeResultsNormal.bg = "NONE";
    TelescopeResultsBorder.bg = "NONE";
    TelescopePreviewNormal.bg = "NONE";
    TelescopePreviewBorder.bg = "NONE";
  };
}
