{pkgs ? import <nixpkgs> {}, ...}: {
  
  llmster = pkgs.callPackage ./llmster {};
  # some-tool = pkgs.callPackage ./some-tool {};
}
