{ pkgs, ... }: {
  # ----- local mumble server, phone connects to this -----
  services.murmur.enable = true;

  networking.firewall.allowedTCPPorts = [64738];
  networking.firewall.allowedUDPPorts = [64738];
}
