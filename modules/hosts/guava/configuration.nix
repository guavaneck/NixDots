{ self, inputs, ...}: {

  flake.nixosModules.guavaConfiguration = { pkgs, lib, ...}: {
    imports = [
      self.nixosModules.guavaHardware
      self.nixosModules.niri
      self.nixosModules.fish
      self.nixosModules.alacritty
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    
    networking.hostName = "guava";
    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";

    services.pulseaudio.enable = false;

    security.rtkit.enable = true; 
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.pipewire.extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 32;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 32;
      };
    };

    services.displayManager.ly.enable = true;

    services.tailscale.enable = true;

    environment.systemPackages = with pkgs; [
      git
      firefox
      neovim
      alacritty
      ly
      yazi
      networkmanagerapplet
      zip
      discord
      tailscale
    ];

    users.users.guava = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      packages = with pkgs; [
        tree
      ];
      shell = pkgs.fish;
    };

     
    programs.fish.enable = true;
    programs.firefox.enable = true;
    programs.niri.enable = true;

  };

}
