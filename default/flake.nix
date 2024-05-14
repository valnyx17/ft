{
  description = "custom flake template using flake parts";
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      perSystem = {
        pkgs,
        lib,
        self',
        inputs',
        ...
      }: {
        devShells.default = with pkgs;
          mkShell {
            nativeBuildInputs = [alejandra treefmt pre-commit];
          };
        packages.example = with inputs'.nixpkgs.legacyPackages;
          stdenv.mkDerivation {
            pname = "example";
            version = "0.1.0";
            src = ./.;
            meta = with lib; {
              description = "example package";
              license = licenses.mit;
              platforms = platforms.linux;
            };
            outputs = ["out" "dev"];

            buildInputs = [];
            builder = ./builder;
          };
        packages.default = self'.packages.example;
      };
      flake = {
        templates.default = {
          path = ./.;
          description = ''
            Minimal flake using flake-parts.
          '';
        };
      };
    };
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
}
