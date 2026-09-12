# defines the NixOS configurations used to test disko-install-menu's
# offline capability (see the main flake's tests/offlineBuilds.nix)
{
  lib,
  self,
  ...
}@top:
let
  inherit (lib) nixosSystem;
  inherit (lib.attrsets) mapAttrs' nameValuePair;
  inherit (lib.trivial) flip;

  # test configurations
  testCases = {

    minimal = { };

    systemConfigRevision = {
      # reflects a value which differs in online vs offline evaluation
      # (system.configurationRevision -> nixos-version -> environment.systemPackages)
      system.configurationRevision = toString (
        self.shortRev or self.dirtyShortRev or self.lastModified or "unknown"
      );
    };

    systemCheckOnRevision = {
      # change of configurationRevision triggers requirement on all system.checks
      imports = [
        testCases.systemConfigRevision
      ];
      # openssh module adds a (seemingly) non-trivial system.checks
      services.openssh.enable = true;
    };

  };
in
{
  _class = "flake";
  perSystem =
    { system, ... }@systemArg:
    {
      nixosTemplates = flip mapAttrs' testCases (
        name: module:
        nameValuePair "test-${name}" (nixosSystem {
          modules = [
            self.nixosModules.support
            self.nixosModules.test-configDefaults # minimal for successful build
            module
          ];
          inherit system;
        })
      );
    };
}
