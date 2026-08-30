{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeBinaryWrapper,
  addDriverRunpath,
  libgcc,
  libxcrypt-legacy,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "llmster";
  version = "0.0.21-2";

  src = fetchurl {
    url = "https://llmster.lmstudio.ai/download/${finalAttrs.version}-linux-x64.full.tar.gz";
    hash = "sha256-RNYgxfCfBSVzWn/LhsBfs/vINl62ed9xtmK8DeQuryU=";
  };
  
  buildInputs = [
    stdenv.cc.cc.lib
    libgcc
    libxcrypt-legacy
  ];

  nativeBuildInputs =
    [makeBinaryWrapper]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      autoPatchelfHook
      addDriverRunpath
    ];

  # bun-compiled binaries break if stripped
  dontStrip = true;
  dontConfigure = true;
  dontBuild = true;
  sourceRoot = ".";

  # actual GPU driver libs aren't known at build time
  autoPatchelfIgnoreMissingDeps = [
    "libcuda.so.1"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/libexec
    mv llmster .bundle $out/libexec/
    makeWrapper $out/libexec/llmster $out/bin/llmster
    makeWrapper $out/libexec/.bundle/lms $out/bin/lms

    runHook postInstall
  '';

  # .so and .node files can both contain native code needing the driver runpath
  postFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    find $out/libexec/.bundle -type f \( -name '*.so' -o -name '*.so.*' -o -name '*.node' \) | while read -r lib; do
      addDriverRunpath "$lib"
    done
  '';

  meta = {
    description = "Headless LM Studio server (llmster) and its lms CLI";
    homepage = "https://lmstudio.ai/";
    license = lib.licenses.unfree;
    mainProgram = "lms";
    platforms = ["x86_64-linux"];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
