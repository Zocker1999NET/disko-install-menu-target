{ lib, ... }@top:
let
  inherit (lib.lists) singleton;
in
{

  _class = "flake";

  flake.nixosModules.support.imports = singleton ./module.nix;
}
