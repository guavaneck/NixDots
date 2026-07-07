{pkgs, ...}: {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;

    checkConfig = false;

    extraConfig = ''
      corner_radius 10
      shadows enable
      shadow_blur_radius 20
      blur enable
      blur_radius 5
      blur_passes 2
      dim_inactive 0.15
    '';

    config = {
      modifier = "Mod4";
      terminal = "${pkgs.kitty}/bin/kitty";
      
    };
  };
}
