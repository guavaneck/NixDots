{ self, inputs, ... }: {
  flake.nixosModules.fish = { pkgs, lib, ... }: {

    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting ""

        function rebuild-diff
            set before (nix-store --query --requisites /run/current-system | sort)
            sudo nixos-rebuild switch --flake ~/Dotfiles#guava
            set after (nix-store --query --requisites /run/current-system | psub)
            diff (echo $before | psub) (echo $after | psub)
        end
      '';

      shellAliases = {
        rebuild  = "sudo nixos-rebuild switch --flake ~/Dotfiles#guava";
        dotfiles = "cd ~/Dotfiles";
        ls       = "ls --color=auto";
        ll       = "ls -lah --color=auto";
      };
    };

  };
}
