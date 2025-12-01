{
  description = "petrol's nixos & nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #impermanence.url = "github:nix-community/impermanence";
    #impermanence.inputs.nixpkgs.follows = "nixpkgs";
    #impermanence.home-manager.follows = "home-manager";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = {
      self,
      nixpkgs,
      nixpkgs-master,
      nix-darwin,
      nixos-hardware,
      home-manager,
      plasma-manager,
      ...
  } @inputs: let
    vars = {
      user = "lain";
      editor = "emacs";
    };
    # supported systems for flakes, shell, etc.
    systems = [
      "aarch64-darwin"
      "x86_64-linux"
    ];
  in {
    nixosConfigurations = {
      "oak" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/nixos/desktop
          #disko.nixosModules.disko
          home-manager.nixosModules.home-manager {
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."lain" = import ./hosts/nixos/home.nix;
          }
        ];
      };
    };

    darwinConfigurations = {
      "norns" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = inputs;
        modules = [
          ./darwin
          home-manager.darwinModules.home-manager
        ];
      };
    };
  };
}
