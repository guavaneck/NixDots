{
  alsa-lib,
  dbus,
  fetchFromGitHub,
  lib,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "koan";
  version = "0.33.2";

  src = fetchFromGitHub {
    owner = "radiosilence";
    repo = "koan";
    rev = "v${version}";
    hash = "sha256-9pIN6zwXvXBWXIUhrAv58XErpTZaOgmqgo8+rp97a2o=";
  };

  patches = [./fix-linux-default-device.patch];

  cargoHash = "sha256-bED8owkslTdgxNytk7HqVPOyzCxA2yxr3jIcEnU02+Q=";

  nativeBuildInputs = [pkg-config];
  buildInputs = [
    alsa-lib
    dbus
  ];

  cargoBuildFlags = [
    "--package"
    "koan-cli"
  ];
  cargoTestFlags = [
    "--package"
    "koan-cli"
  ];

  meta = {
    description = "Music player for local and Subsonic collections";
    homepage = "https://github.com/radiosilence/koan";
    license = lib.licenses.mit;
    mainProgram = "koan";
    platforms = lib.platforms.linux;
  };
}
