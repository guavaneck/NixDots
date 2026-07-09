{
  pkgs,
  config,
  ...
}: let
  colors = config.colorScheme;
  font = config.fontProfiles.monospace.name;

  # ---- small helper scripts, replacing omarchy-specific binaries ----

  mprisBracketVisible = side:
    pkgs.writeShellScript "waybar-mpris-bracket-${side}" ''
      if ${pkgs.playerctl}/bin/playerctl status 2>/dev/null | grep -qE "Playing|Paused"; then
        echo "{\"text\":\"${side}\",\"class\":\"show\"}"
      else
        echo "{\"text\":\"\",\"class\":\"hide\"}"
      fi
    '';

  trayIndicator = pkgs.writeShellScript "waybar-tray-indicator" ''
    count=$(${pkgs.systemd}/bin/busctl --user get-property org.kde.StatusNotifierWatcher /StatusNotifierWatcher org.kde.StatusNotifierWatcher RegisteredStatusNotifierItems 2>/dev/null | sed -n 's/^as \([0-9]\+\).*/\1/p')
    if [ "''${count:-0}" -gt 0 ]; then
      echo "{\"text\":\"\",\"class\":\"show\"}"
    else
      echo "{\"text\":\"\",\"class\":\"hide\"}"
    fi
  '';

  notificationSilenceStatus = pkgs.writeShellScript "waybar-notification-silence-status" ''
    if ${pkgs.mako}/bin/makoctl mode 2>/dev/null | grep -q "do-not-disturb"; then
      echo "{\"text\":\"dnd on\",\"class\":\"active\"}"
    else
      echo "{\"text\":\"dnd off\",\"class\":\"inactive\"}"
    fi
  '';

  batteryStatusNotify = pkgs.writeShellScript "waybar-battery-status-notify" ''
    capacity=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1)
    status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n1)
    ${pkgs.libnotify}/bin/notify-send -u low "Battery" "''${capacity:-?}% (''${status:-unknown})"
  '';
in {
  home.packages = with pkgs; [
    playerctl
    btop
    pavucontrol
    pamixer
    libnotify
  ];

  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      target = "sway-session.target";
    };

    settings.mainBar = {
      exclusive = true;
      reload_style_on_change = true;
      position = "top";
      margin-top = 0;
      spacing = 0;
      height = 0;
      margin-bottom = 0;

      modules-left = [
        "sway/workspaces"
        "custom/separator"
        "tray"
        "custom/separator7"
        "idle_inhibitor"
        "custom/notification-silencing-indicator"
        "custom/separator2"
        "custom/separator5"
        "mpris"
        "custom/separator6"
      ];
      modules-center = ["custom/separator" "custom/clock" "custom/separator2"];
      modules-right = [
        "custom/separator"
        "bluetooth"
        "custom/separator3"
        "backlight"
        "custom/separator4"
        "battery"
        "custom/separator4"
        "power-profiles-daemon"
        "custom/separator3"
        "network"
        "custom/separator3"
        "pulseaudio"
        "custom/separator3"
        "memory"
        "custom/separator3"
        "cpu"
        "custom/separator2"
      ];

      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{icon}";
        persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
          "6" = [];
          "7" = [];
          "8" = [];
          "9" = [];
          "10" = [];
        };
      };

      "custom/separator" = {
        format = "[";
        tooltip = false;
      };
      "custom/separator2" = {
        format = "]";
        tooltip = false;
      };
      "custom/separator3" = {
        format = "󰿟";
        tooltip = false;
      };
      "custom/separator4" = {
        exec = "sh -c '[ -d /sys/class/backlight ] && [ \"$(ls -A /sys/class/backlight 2>/dev/null)\" ] && ls /sys/class/power_supply 2>/dev/null | grep -q \"^BAT\" && echo \"󰿟\"'";
        tooltip = false;
        interval = "once";
      };
      "custom/separator5" = {
        exec = "${mprisBracketVisible "["}";
        return-type = "json";
        interval = 2;
        format = "{}";
      };
      "custom/separator6" = {
        exec = "${mprisBracketVisible "]"}";
        return-type = "json";
        interval = 2;
        format = "{}";
      };
      "custom/separator7" = {
        exec = "${trayIndicator}";
        return-type = "json";
        interval = 2;
      };

      "custom/notification-silencing-indicator" = {
        exec = "${notificationSilenceStatus}";
        on-click = "${pkgs.mako}/bin/makoctl mode -t do-not-disturb";
        return-type = "json";
        interval = 2;
        tooltip-format = "Click to toggle do-not-disturb";
      };

      "power-profiles-daemon" = {
        justify = "center";
        format = "power {icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          performance = "<span style='italic' weight='900' color='${colors.accent}'>perf</span>";
          balanced = "<span style='italic' weight='900' color='${colors.accent}'>bal</span>";
          power-saver = "<span style='italic' weight='900' color='${colors.accent}'>eco</span>";
        };
      };

      cpu = {
        interval = 10;
        format = "cpu {usage:02}%";
        on-click = "${pkgs.kitty}/bin/kitty -e ${pkgs.btop}/bin/btop";
        states = {
          warning = 50;
          critical = 80;
        };
      };

      backlight = {
        device = "intel_backlight";
        rotate = 0;
        format = "bl {percent}%";
        tooltip-format = "🌕 {percent}%";
        format-icons = ["󰃜" "󰃝" "󰃞" "󰃟" "󰃠"];
      };

      memory = {
        interval = 2;
        format = "mem {percentage:02}%";
        on-click = "${pkgs.kitty}/bin/kitty -e ${pkgs.btop}/bin/btop";
        states = {
          warning = 50;
          critical = 80;
        };
      };

      "custom/clock" = {
        exec = "date +'%H:%M %p - %A, %b %d' | tr '[:upper:]' '[:lower:]'";
        interval = 60;
        tooltip = false;
      };

      network = {
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format = "{icon}";
        format-wifi = "net <span style='italic' weight='900' color='${colors.accent}'>{signalStrength}%</span>";
        format-ethernet = "net <span style='italic' weight='900' color='${colors.accent}'>on</span>";
        format-disconnected = "net <span style='italic' weight='900' color='${colors.accent}'>off 󰤮 / 󰈀 </span>";
        tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
        tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
        tooltip-format-disconnected = "Disconnected";
        interval = 3;
        spacing = 1;
        on-click = "${pkgs.kitty}/bin/kitty -e nmtui";
      };

      battery = {
        format = "bat {capacity}%";
        format-discharging = "bat {capacity}%";
        format-charging = "bat {capacity}% ";
        format-plugged = "bat_p {capacity}%";
        format-icons = {
          charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
          default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        format-full = "bat_f {capacity}%";
        tooltip-format-discharging = "{timeTo}";
        tooltip-format-charging = "{timeTo}";
        interval = 5;
        on-click = "swaymsg mode session";
        on-click-right = "${batteryStatusNotify}";
        states = {
          warning = 20;
          critical = 10;
        };
      };

      bluetooth = {
        justify = "center";
        format = "bt <span style='italic' weight='900' color='${colors.accent}'>{status}</span> {num_connections}";
        format-disabled = "bt <span style='italic' weight='900' color='${colors.accent}'>{status}</span>";
        format-connected = "bt <span style='italic' weight='900' color='${colors.accent}'>{status}</span> {num_connections}";
        tooltip-format = "Devices connected: {num_connections}";
        on-click = "${pkgs.kitty}/bin/kitty -e ${pkgs.bluez}/bin/bluetoothctl";
      };

      pulseaudio = {
        justify = "center";
        format = "vol {volume}%";
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        on-click-right = "${pkgs.pamixer}/bin/pamixer -t";
        tooltip-format = "Playing at {volume}%";
        scroll-step = 5;
        format-muted = "vol <span style='italic' weight='900' color='${colors.accent}'>muted</span>";
        format-icons = {
          headphone = "";
          default = ["" "" ""];
        };
        states = {
          warning = 50;
          critical = 10;
        };
      };

      mpris = {
        format = " {dynamic}";
        format-paused = "<span color='grey'>{status_icon} {dynamic}</span>";
        title-len = 20;
        dynamic-order = ["artist" "title"];
        tooltip-format = "{player} ({status}):\n{artist} - {title}";
        status-icons = {
          paused = "󰝛";
        };
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "idle <span style='italic' weight='900' color='${colors.accent}'>on</span>";
          deactivated = "idle <span style='italic' weight='900' color='${colors.accent}'>off</span>";
        };
      };

      tray = {
        icon-size = 14;
        spacing = 4;
      };
    };

    style = ''
      * {
        border: none;
        padding: 0px;
        font-family: "${font}";
        transition: background-color .3s ease-out;
        font-weight: bold;
        font-size: 12px;
      }

      window#waybar {
        background-color: transparent;
      }

      #waybar > box {
        border-radius: 0px;
        border-bottom: 1.5px solid rgba(255, 255, 255, 0.1);
        margin: 0px 0px 2px 0px;
        background-color: ${colors.background};
        box-shadow: 0 1px 2px rgba(0, 0, 0, 1);
        min-height: 25px;
        transition-property: background-color;
        transition-duration: .5s;
      }

      .modules-left {
        margin-left: 4px;
      }

      .modules-right {
        margin-right: 4px;
      }

      #workspaces {
        margin: 0px 0px;
        transition: 0.1s ease-in-out;
        padding: 0px 0px;
      }

      #workspaces button {
        all: initial;
        padding: 0px 4px;
        margin: 4px 2px;
        min-width: 10px;
        color: ${colors.foreground};
        opacity: 1;
        font-weight: 900;
      }

      #workspaces button.active {
        color: ${colors.background};
        background-color: ${colors.accent};
        padding: 0px 4px;
        margin: 4px 2px;
        opacity: 1.0;
      }

      #workspaces button.empty:hover,
      #workspaces button:hover {
        background: transparent;
        color: alpha(${colors.foreground}, 1);
        transition: all 150ms ease;
        opacity: 0.75;
      }

      #workspaces button.empty {
        opacity: 0.4;
        padding: 0px 4px;
        margin: 4px 2px;
        color: alpha(${colors.foreground}, 0.45);
      }

      #workspaces button.empty.active {
        opacity: 1;
        background-color: ${colors.foreground};
        color: ${colors.background};
      }

      #memory,
      #mpris,
      #tray,
      #cpu,
      #custom-clock,
      #battery,
      #backlight,
      #network,
      #bluetooth,
      #pulseaudio,
      #power-profiles-daemon,
      #power-profiles-daemon.performance,
      #power-profiles-daemon.balanced,
      #power-profiles-daemon.power-saver,
      #idle_inhibitor,
      #custom-notification-silencing-indicator {
        min-width: 12px;
        padding: 0 4px;
        margin: 1px 3px 1px 3px;
        opacity: 1;
      }

      #tray {
        opacity: 1;
        padding-top: 2px;
      }

      #idle_inhibitor.deactivated {
        opacity: 0.5;
      }

      #idle_inhibitor.activated {
        opacity: 1;
      }

      #network {
        margin-left: 0;
      }

      #custom-separator7,
      #custom-separator6,
      #custom-separator5,
      #custom-separator4,
      #custom-separator3,
      #custom-separator2,
      #custom-separator {
        opacity: 0.2;
        padding-top: 2px;
        padding-left: 2px;
        padding-right: 2px;
        font-size: 14px;
      }

      tooltip {
        padding: 4px;
        background: ${colors.background};
        font-size: 10px;
        border: 1.5px solid alpha(${colors.foreground}, 0.6);
        border-radius: 8px;
      }

      tooltip label {
        color: alpha(${colors.foreground}, 0.65);
        font-weight: normal;
      }

      #custom-notification-silencing-indicator {
        min-width: 12px;
        margin-left: 0;
        margin-right: 0;
        font-size: 12px;
        padding-bottom: 0px;
      }

      #custom-notification-silencing-indicator.active {
        color: ${colors.red};
        opacity: 1;
      }

      .hidden {
        opacity: 0;
      }

      #mpris {
        opacity: 1;
        color: ${colors.foreground};
        animation: repeat;
        animation-name: blink;
        animation-duration: 3s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
          color: ${colors.brightBlack};
        }
      }

      #battery.warning {
        color: ${colors.yellow};
      }

      @keyframes blink2 {
        to {
          background-color: transparent;
          color: #f53c3c;
        }
      }

      #battery.critical:not(.charging) {
        background-color: transparent;
        color: #e6d8ba;
        animation-name: blink2;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #pulseaudio.warning,
      #memory.warning,
      #cpu.warning {
        color: #e3c1b1;
        background-color: ${colors.background};
      }

      #pulseaudio.critical,
      #memory.critical,
      #cpu.critical {
        color: ${colors.accent};
        background-color: ${colors.background};
      }
    '';
  };

  services.mako = {
    enable = true;
    settings.criteria = {
      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };
}
