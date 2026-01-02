{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    user = "borba";
    homeStateVersion = "25.11";

    hosts = [
      { hostname = "slim3"; stateVersion = "24.05"; }
      { hostname = "caveos-dell"; stateVersion = "25.11"; }
    ];

    makeSystem = { hostname, stateVersion }:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs hostname stateVersion user homeStateVersion;
        };

        modules = [
          ./hosts/${hostname}/configuration.nix

          # Home Manager integrado ao NixOS
          inputs.home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
              inherit inputs user homeStateVersion;
            };

            home-manager.users.${user} =
              import ./home-manager/home.nix;
          }
        ];
      };
  in
  {
    nixosConfigurations =
      nixpkgs.lib.foldl' (configs: host:
        configs // {
          ${host.hostname} = makeSystem {
            inherit (host) hostname stateVersion;
          };
        }
      ) {} hosts;

    # Home Manager standalone (fallback / uso futuro)
    homeConfigurations.${user} =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        extraSpecialArgs = {
          inherit inputs user homeStateVersion;
        };

        modules = [
          ./home-manager/home.nix
        ];
      };
  };
}
