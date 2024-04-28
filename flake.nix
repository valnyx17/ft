{
  description = "custom flake template using flake parts";
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devshell.flakeModule
      ];
      systems = ["x86_64-linux"];
      perSystem = {
        pkgs,
        lib,
        self',
        inputs',
        ...
      }: {
        devshells.default = {
          packages = [];
          commands = [];
          env = [];
          motd = ''
            {63}welcome to devshell{reset}
            $(type -p menu &>/dev/null && menu)
          '';
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
    devshell.url = "github:numtide/devshell";
  };
}
