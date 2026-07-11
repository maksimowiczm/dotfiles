{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      plasma-manager,
      lanzaboote,
      ...
    }:
    let
      system = "x86_64-linux";

      mkHost =
        hostPath:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            hostPath
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
            ({ config, ... }: {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                plasma-manager.homeModules.plasma-manager
              ];
              home-manager.extraSpecialArgs = {
                pkgsUnstable = import nixpkgs-unstable {
                  inherit system;
                  config = config.nixpkgs.config;
                  overlays = config.nixpkgs.overlays;
                };
              };
              home-manager.users.mateusz = import ./home/mateusz.nix;
            })
          ];
        };
    in
    {
      nixosConfigurations = {
        workstation = mkHost ./hosts/workstation/configuration.nix;
      };
    };
}
