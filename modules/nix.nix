{pkgs, ...}: {
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes" "pipe-operators"];
    # fallback = true; # fall back to building from source if binary substitute fails
    show-trace = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    #enableParallelBuildingByDefault = true;
    warnUndeclaredOptions = true;
  };
}
