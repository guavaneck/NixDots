{pkgs, ...}: {
  environment.systemPackages = [pkgs.swayfx];

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
  };

  # ----- login manager -----
  services.displayManager.ly.enable = true;
}


