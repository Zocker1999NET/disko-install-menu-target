# disko-install-menu-target

Test target flake for [disko-install-menu][1].

> [!NOTE]
> For now, this flake is only meant to be consumed by my [disko-install-menu][1].
> The outputs provided by this flake are passed through by [disko-install-menu][1].


## Why does this flake exist?

This flake is forked out of the main [disko-install-menu][1] flake
to provide a **stable test target** for its offline capability tests.

The main flake's `offlineBuilds-*` tests install a NixOS configuration fully offline.
To do so, they inject the target flake's source
(the flake which defines the target configuration)
as extra dependency into the installer.

If those configurations would be declared in the main flake itself,
then for **every commit or change** to the main flake
the store path of the flake source would change,
leading to a different store path for the test case being evaluated.
This causes the `offlineBuilds-*` tests to be rebuild
even for unrelated changes (e.g. a README edit).

By keeping the target configurations in this **separate flake with its own git repository**,
their store path only changes when *this* flake changes.
This results into the tests only being rebuild
for changes to the main flake
when those are actually relevant for the test success.


## What does it define?

- disko-install-menu support module
  - as `nixosModules.support`
  - should be imported by installable configurations
  - provides fancy system description preview & boot loader build dependencies
  - see [main flake documentation][1] for more info

- test configurations used by `offlineCapable-*` tests
  - defined & exported perSystem in `nixosTemplates.<system>.<name>`
  - translated to `nixosConfigurations.<name>_<system>`
    - as [disko-install-menu][1] expects configurations to be available there

- flake.parts module declaring perSystem `nixosTemplates` & translating to `nixosConfigurations`
  - exported as `modules.flake.perSystemConfig`
  - can be used independent from disko-install-menu


## Git History

As this flake was forked out of the main flake,
and to keep the original Git history for the files moved here,
they share their commits from root until
d53759ca52fea0cf3a86c6d94d83ba69bbec1f1a.


## License

<!-- SPDX-License-Identifier: MIT -->
The content of this repository is licensed under the MIT license.
You are free to use & modify the content of this repository.
You are asked to contribute your improvements back to the FLOSS community,
e.g. by making a PR into this repository.

A copy of the MIT license is [attached](./LICENSE) to the repository.


[1]: https://github.com/Zocker1999NET/disko-install-menu
