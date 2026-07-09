{pkgs, inputs, ...}: let 
  mod   = "Mod4"; 

  left  = "h";
  down  = "j";
  up    = "k";
  right = "l";

  swaymonad = "${inputs.swaymonad.defaultPackage.${pkgs.system}}/bin/swaymonad"; 


in {
  imports = [
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    inputs.swaymonad.defaultPackage.${pkgs.system}
    wofi
    cliphist
    wl-clipboard
    grim
    slurp
    ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;

    systemd.enable = true;

    extraConfig = ''
      # ---- Window ----
      corner_radius 20
      gaps inner 10

      shadows enable
      shadow_blur_radius 20
      blur enable
      blur_radius 5
      blur_passes 2

      default_border pixel 2
      default_floating_border pixel 2
      for_window [class=".*"] dim_inactive_colors.unfocused-hovered #000000FF
      for_window [app_id=".*"] dim_inactive_colors.unfocused-hovered #000000FF

      # ----- swaymonad -----
      exec_always ${swaymonad}

      bindsym ${mod}+Shift+${left} nop move left
      bindsym ${mod}+Shift+${down} nop move down
      bindsym ${mod}+Shift+${up} nop move up
      bindsym ${mod}+Shift+${right} nop move right

      mouse_warping container
      focus_wrapping yes
    '';

    config = {
      modifier = "Mod4";
      terminal = "${pkgs.kitty}/bin/kitty";

      floating.modifier = "Mod4 normal";

      output."eDP-1" = {
        mode = "1920x1080@60Hz";
        scale = "1";
      };

      keybindings = {
        "${mod}+q" = "kill";
        "${mod}+Shift+r" = "reload";
        "${mod}+Shift+e" = "exec swaymsg exit";
      
        "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${mod}+space" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${mod}+Shift+v" = "exec ${pkgs.cliphist}/bin/cliphist list | ${pkgs.wofi}/bin/wofi --dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy";
        "${mod}+s" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "${mod}+Shift+s" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\"";
      
        "--locked XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "--locked XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "--locked XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "--locked XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
      
        "--locked XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
        "--locked XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";

        "${mod}+b" = "splith";
        "${mod}+v" = "splitv";
        "${mod}+e" = "layout toggle split";
        "${mod}+f" = "fullscreen";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+Tab" = "focus mode_toggle";
        "${mod}+a" = "focus parent";
      
        "${mod}+${left}" = "focus left";
        "${mod}+${down}" = "focus down";
        "${mod}+${up}" = "focus up";
        "${mod}+${right}" = "focus right";
      
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";
      
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        # ---- Modes ----
        "${mod}+r" = "mode resize";
        "${mod}+x" = "mode session";
      };  
      modes = {
        resize = {
          Escape = "mode default";
          Return = "mode default";
          "${down}" = "resize grow height 15 px or 15 ppt";
          "${left}" = "resize shrink width 15 px or 15 ppt";
          "${right}" = "resize grow width 15 px or 15 ppt";
          "${up}" = "resize shrink height 15 px or 15 ppt";
        };
        session = {
          # Session = launch:
          # [h]ibernate [p]oweroff [r]eboot
          # [s]uspend [l]ockscreen log[o]ut
          Escape = "mode default";
          Return = "mode default";
          "h" = "exec systemctl hibernate, mode default";
          "p" = "exec systemctl poweroff, mode default";
          "r" = "exec systemctl reboot, mode default";
          "s" = "exec systemctl suspend, mode default";
          #"l" = "exec ${swaylock}/bin/swaylock, mode default";
          "o" = "exec swaymsg exit, mode default";
        };
      };
    };
  };
}
