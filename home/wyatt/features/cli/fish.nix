{config, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
      upgrade = "sudo nixos-rebuild switch --flake $HOME/dotfiles/";
    };
  };
}
