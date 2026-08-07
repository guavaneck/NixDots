{ pkgs, ... }:

{
services.pipewire.enable = false;
services.pulseaudio.enable = true;
services.pulseaudio.support32Bit = true;
}
