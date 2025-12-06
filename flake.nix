{
  description = "do1ptb nix cluster";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    #impermanence.url = "github:nix-community/impermanence";
    #impermanence.inputs.nixpkgs.follows = "nixpkgs";
    #impermanence.home-manager.follows = "home-manager";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs,nixpkgs-master,nix-darwin,nixos-hardware,disko,mac-app-util, ... }: 
    let
      overlay = final: prev: {
        nixpkgs-master = import nixpkgs-master { inherit (prev) system; config.allowUnfree = true; };
      };
      # Overlays-module makes "pkgs.unstable" available in configuration.nix
      overlayModule = ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; });
      # extract hostname from hostname.nix
      hostnames = builtins.attrNames (builtins.readDir ./hosts);
      systemForHost = hostname:
        if builtins.elem hostname ["host1" "host2"] then "aarch64-linux"
        else "x86_64-linux";
      # available through $> nix fmt
      #formatter.x86_64-linux = nixpkgs.legacyPackages.${system}.alejandra;
      #formatter.aarch64-darwin = nixpkgs.legacyPackages.${system}.alejandra;
    in {
      nixosConfigurations = builtins.listToAttrs (builtins.map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          system = systemForHost host;
          specialArgs = {
            inherit inputs;
          };
          modules = [ overlayModule ./hosts/${host}/configuration.nix ];
        };
      }) hostnames);
    };
}
