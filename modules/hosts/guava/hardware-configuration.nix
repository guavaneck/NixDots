{ self, inputs, ... }: {
  
  flake.nixosModules.guavaHardware = { config, lib, pkgs, modulesPath, ...}: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/0bbd3c6b-25ad-41ac-b37e-bb78564ceacc";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/5A77-FDE3";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };
    fileSystems."/home/shared" = 
      { device = "/dev/disk/by-uuid/af72231e-6904-49f6-9169-5ab117440511";
        fsType = "ext4";
      };
    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
