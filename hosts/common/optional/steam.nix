{pkgs, ...}: {
  # ----- 32-bit graphics -----
  # steamwebhelper runs out of ubuntu12_32 and needs 32-bit GL/Vulkan
  # without this you get "failed create vulkan instance" / "glXChooseVisual failed"
  hardware.graphics.enable32Bit = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    # steamwebhelper (CEF) crash-loops on RADV due to GPU compositing bugs
    package = pkgs.steam.override {
      extraArgs = "-cef-disable-gpu-compositing";
    };
  };
}
