{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/wyatt

    ../common/optional/sway.nix
    ../common/optional/docker.nix
    ../common/optional/pipewire.nix
    ../common/optional/steam.nix
  ];
 
  environment.systemPackages = [
    pkgs.brightnessctl
  ];

  networking.hostName = "guava";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;

  system.stateVersion = "24.05";
}
