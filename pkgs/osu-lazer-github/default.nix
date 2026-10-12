{
  lib,
  appimageTools,
  fetchurl,
  makeWrapper,
}: let
  pname = "osu-lazer-github";
  version = "2026.804.2";

  src = fetchurl {
    url = "https://github.com/ppy/osu/releases/download/${version}-lazer/osu.AppImage";
    hash = "sha256-0K/dyvIwrlBzcexYDCCilNknJdEZja1OTfAotP6MvjY=";
  };
in
  appimageTools.wrapType2 (finalAttrs: {
    inherit pname version src;

    extraPkgs = pkgs: [pkgs.icu];

    # Fix OpenGL rendering with NVIDIA under Wayland.
    extraBwrapArgs = [
      "--ro-bind-try /etc/egl/egl_external_platform.d /etc/egl/egl_external_platform.d"
    ];

    extraInstallCommands = ''
      . ${makeWrapper}/nix-support/setup-hook
      mv "$out/bin/${pname}" "$out/bin/osu!"
      wrapProgram "$out/bin/osu!" --set OSU_EXTERNAL_UPDATE_PROVIDER 1

      install -Dm444 "${finalAttrs.contents}/osu!.desktop" \
        "$out/share/applications/osu!.desktop"
      for size in 16 32 48 64 96 128 256 512 1024; do
        install -Dm444 "${finalAttrs.contents}/osu.png" \
          "$out/share/icons/hicolor/''${size}x''${size}/apps/osu.png"
      done
    '';

    meta = {
      description = "Rhythm is just a *click* away (official GitHub AppImage)";
      homepage = "https://osu.ppy.sh";
      downloadPage = "https://github.com/ppy/osu/releases";
      license = with lib.licenses; [
        mit
        cc-by-nc-40
        unfreeRedistributable
      ];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      mainProgram = "osu!";
      platforms = ["x86_64-linux"];
    };
  })
