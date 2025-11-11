{ slimevr-wrangler-src }: _: prev: {
  slimevr-wrangler = prev.callPackage ./package.nix { inherit slimevr-wrangler-src; };
}
