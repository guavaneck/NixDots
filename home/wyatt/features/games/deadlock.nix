{ pkgs, config, ... }: 
{
  home.packages = [
    pkgs.deadlock-mod-manager
  ];
}
