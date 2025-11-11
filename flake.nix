{
  description = "Use Joycons as SlimeVR trackers with this middleware application";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    slimevr-wrangler-src = {
      url = "github:carl-anders/slimevr-wrangler/main";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, slimevr-wrangler-src, ... }@inputs: let
    inherit (nixpkgs) lib;
    inherit (lib.attrsets) genAttrs;
    forAllSystems = genAttrs lib.systems.flakeExposed;
    pkgs' = system: import nixpkgs {
      inherit system;
    };
  in {
      packages = forAllSystems (system: let
        pkgs = pkgs' system;
        slimevr-wrangler = pkgs.callPackage ./package.nix { inherit slimevr-wrangler-src; };
      in {
        inherit slimevr-wrangler;
        default = slimevr-wrangler;
      });

      overlays.default = import ./overlay.nix { inherit slimevr-wrangler-src; };
    };
}
