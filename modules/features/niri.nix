{ self, inputs, ... }: {
  
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {

    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];
        
        hotkey-overlay = {
            skip-at-startup = {};
        };

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
        input = {
          warp-mouse-to-focus = {};
          focus-follows-mouse = {};
        };

        input.keyboard = {
          xkb.layout = "us,ua";
          numlock = {};
        };
        
        input.touchpad = {
          tap = {};
          natural-scroll = {};
        };

        layout.border = { off = {}; }; 
        layout.gaps = 5;
        
        layout.focus-ring = {
          width = 2;
          active-color = "#7fc8ff";
          inactive-color = "#505050";
        };

        prefer-no-csd = {};

        window-rule = {
          geometry-corner-radius = 12;
          clip-to-geometry = true;
        };
        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
          "Mod+E".spawn-sh = lib.getExe pkgs.yazi;
          "Mod+Q".close-window = {};
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
        };
      };
    };
  };
}
