{
  description = "flake templates";
  outputs = {self, ...} @ inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      flake = {lib, ...}: {
        templates.default = {
          path = ./default;
          description = ''
            Minimal flake using flake-parts.
          '';
          welcomeText = ''
            # Getting Started
            - Run `nix develop`
            - Initialize your project!
          '';
        };
        templates.rust = {
          path = ./rust;
          description = ''
            Minimal flake for rust using flake-parts.
          '';
          welcomeText = ''
            # Getting Started
            - Run `nix develop`
            - Run `cargo init`
          '';
        };
      };
    };
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
}
