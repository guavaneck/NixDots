{ self, inputs, ... }: {
  flake.nixosModules.alacritty = { pkgs, lib, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myAlacritty
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.myAlacritty = inputs.wrapper-modules.wrappers.alacritty.wrap {
      inherit pkgs;
      settings = {
        window = {
          padding = { x = 12; y = 12; };
          opacity = 0.95;
          decorations = "None";
        };
        font = {
          size = 13;
          normal = { family = "monospace"; style = "Regular"; };
          bold   = { family = "monospace"; style = "Bold"; };
          italic = { family = "monospace"; style = "Italic"; };
        };
        colors = {
          primary   = { background = "#111111"; foreground = "#828282"; };
          cursor    = { text = "#111111"; cursor = "#aaaaaa"; };
          selection = { text = "#111111"; background = "#828282"; };
          normal = {
            black = "#191919"; red = "#dddddd"; green = "#cccccc";
            yellow = "#aaaaaa"; blue = "#a7a7a7"; magenta = "#dddddd";
            cyan = "#cccccc"; white = "#828282";
          };
          bright = {
            black = "#3c3c3c"; red = "#dddddd"; green = "#cccccc";
            yellow = "#aaaaaa"; blue = "#a7a7a7"; magenta = "#dddddd";
            cyan = "#cccccc"; white = "#ffffff";
          };
        };
      };
    };
  };
}
