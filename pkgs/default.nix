{pkgs ? import <nixpkgs> {}, ...}: {
  koan = pkgs.callPackage ./koan {};
  osu-lazer-github = pkgs.callPackage ./osu-lazer-github {};

  # some-tool = pkgs.callPackage ./some-tool {};
}
