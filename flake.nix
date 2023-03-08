{
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
    {
      templates = {
        go = {
          path = ./go;
          description = "Template for Go projects";
          welcomeText = ''
            Remember to initialize the Go module using `go mod init <module>`.
          '';
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;
    });
}
