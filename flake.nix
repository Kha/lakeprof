{
  description = "A Lake build graph profiler";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      rec {
        packages.lakeprof = pkgs.python3Packages.buildPythonApplication {
          name = "lakeprof";
          src = ./.;

          pyproject = true;
          build-system = with pkgs.python3Packages; [ setuptools ];
          dependencies = with pkgs.python3Packages; [
            click
            networkx
            pydot
            tabulate
          ];

          propagatedBuildInputs = with pkgs; [ moreutils ];
        };

        defaultPackage = packages.lakeprof;
      }
    );
}
