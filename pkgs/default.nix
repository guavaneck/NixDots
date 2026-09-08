{pkgs ? import <nixpkgs> {}, ...}: {

  koan = pkgs.callPackage ./koan {};

  # some-tool = pkgs.callPackage ./some-tool {};
}
