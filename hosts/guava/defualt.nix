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
  ];

  networking.hostName = "guava";

  hardware.graphics.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  system.stateVersion = "24.05";
}
