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
  ];
 
  environment.systemPackages = [
    pkgs.brightnessctl
  ];

  networking.hostName = "guava";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  system.stateVersion = "24.05";
}
