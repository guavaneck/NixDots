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
    ../common/optional/krita.nix
  ];
 
  environment.systemPackages = [
    pkgs.brightnessctl
  ];

  networking.hostName = "rokakaka";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;

  systemd.services.disable-onboard-bluetooth = {
    description = "Power off onboard Realtek Bluetooth adapter";
    after = ["bluetooth.service"];
    wants = ["bluetooth.service"];
    wantedBy = ["bluetooth.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "disable-onboard-bt" ''
        for i in $(seq 1 10); do
          if ${pkgs.bluez}/bin/bluetoothctl list | grep -q "AC:36:1B:F6:DB:14"; then
            printf 'select AC:36:1B:F6:DB:14\npower off\nquit\n' | ${pkgs.bluez}/bin/bluetoothctl
            exit 0
          fi
          sleep 1
        done
      '';
    };
  };

  system.stateVersion = "24.05";
}
