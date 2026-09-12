{
  description = "Test target flake for disko-install-menu";

  inputs = {
    # for flake structure
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs"; # have full nixpkgs.lib
    };
    # for testing
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { lib, ... }@top:
      {

        imports = [
          ./support/default.nix
          ./tests/default.nix
        ];

        systems = [
          "x86_64-linux"
        ];

      }
    );
}
