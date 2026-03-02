{
  description = "A Lake build graph profiler";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs:
    let
      lib = inputs.nixpkgs.lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        rec {
          default = packages.lakeprof;

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
        }
      );
    };
}
