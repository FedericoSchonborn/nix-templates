{
} {
  description = "Project templates for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      goMinor = 20;
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            go = prev."go_1_${goMinor}";
            buildGoModule = prev."buildGo${goMinor}Module";
          })
        ];
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          go
          delve
        ];
      };

      formatter = pkgs.alejandra;
    });
}
