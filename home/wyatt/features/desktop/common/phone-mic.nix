{ config, pkgs, lib, ... }:
let
  createSink = pkgs.writeShellScript "phone-mic-sink" ''
    set -e
    if ! ${pkgs.pulseaudio}/bin/pactl list short sinks | grep -q "PhoneMic"; then
      ${pkgs.pulseaudio}/bin/pactl load-module module-null-sink \
        sink_name=PhoneMic \
        sink_properties=device.description=PhoneMic
    fi
    # ----- clone the monitor into a real source, since apps hide monitor-class devices -----
    if ! ${pkgs.pulseaudio}/bin/pactl list short sources | grep -q "PhoneMicSource"; then
      ${pkgs.pulseaudio}/bin/pactl load-module module-remap-source \
        master=PhoneMic.monitor \
        source_name=PhoneMicSource \
        source_properties=device.description=PhoneMic-Source
    fi
  '';
in {
  home.packages = with pkgs; [
    mumble
    pulseaudio # provides pactl for talking to pipewire-pulse
  ];

  # ----- creates a "PhoneMic" virtual sink at login -----
  # in mumble: settings > audio output > device = PhoneMic
  # then pick "PhoneMic-Source" as the mic input in whatever app needs it
  systemd.user.services.phone-mic-sink = {
    Unit.Description = "create virtual pipewire sink for phone mic";
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${createSink}";
    };
  };
}
