{ config, pkgs, ...}: 
in {
  home.packages = with pkgs; [vesktop];
}
