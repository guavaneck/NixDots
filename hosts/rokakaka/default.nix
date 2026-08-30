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
    ../common/optional/obs.nix
    ../common/optional/pc-bluetooth-fix.nix
    ../common/optional/mumble-server.nix
  ];
 
  environment.systemPackages = [
    pkgs.brightnessctl
    pkgs.easyeffects
    pkgs.kicad
  ];

  networking.hostName = "rokakaka";
  networking.networkmanager.settings = {
    device = {
      "wifi.scan-rand-mac-address" = false;
    };
  };
  
  programs.obs-studio.enableVirtualCamera = true;
 
  services.flatpak.enable = true;

  services.udev.extraRules = ''
    # ----- yunzii keyboard hid access for wyatt only -----
    KERNEL=="hidraw*", ATTRS{idVendor}=="3151", MODE="0660", OWNER="rokakaka", TAG+="uaccess"
  '';

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev"; # or your disk, e.g. "/dev/sda" if not using EFI
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.grub.extraEntries = ''
    menuentry "Windows" {
      insmod part_gpt
      insmod fat
      insmod chain
      search --fs-uuid --set=root B226-4143
      chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';
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
