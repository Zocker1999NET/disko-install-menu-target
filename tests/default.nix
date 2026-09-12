{ ... }@top:
{

  imports = [
    ./_configDefaults.nix
    ./_perSystemConfig.nix
    ./testCases.nix
  ];

  flake.modules.flake.perSystemConfig = ./_perSystemConfig.nix;

}
