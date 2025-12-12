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

    #disko.url = "github:nix-community/disko";
    #disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-master,
    nix-darwin,
    nixos-hardware,
    disko,
    home-manager,
    mac-app-util,
    ...
  }: let
    overlay = final: prev: {
      nixpkgs-master = import nixpkgs-master {
        inherit (prev) system;
        config.allowUnfree = true;
      };
    };

    # Overlays-module makes "pkgs.unstable" available in configuration.nix
    overlayModule = {
      config,
      pkgs,
      ...
    }: {nixpkgs.overlays = [overlay];};

    hostnames = builtins.attrNames (builtins.readDir ./hosts);

    systemForHost = hostname:
      if builtins.elem hostname [ "norns" ] then "aarch64-darwin";
      # else "x86_64-linux";

  in {
    # available through `nix fmt`
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    
    nixosConfigurations = builtins.listToAttrs (builtins.map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          system = systemForHost host;
          specialArgs = {
            inherit inputs;
          };
          modules = [overlayModule ./hosts/${host}/configuration.nix];
        };
      })
      hostnames);

    darwinConfigurations = builtins.listToAttrs (builtins.map (host: {
        name = host;
        value = nix-darwin.lib.darwinSystem {
          system = systemForHost host;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./darwin/modules/darwin.nix
            ./darwin/modules/homebrew.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.ptb.imports = [
                ./darwin/modules
              ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                system = "aarch64-darwin";
              };
            }
          ];
        };
      })
      hostnames);
  };
}
