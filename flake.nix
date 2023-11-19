{
  inputs = {
    nixpkgs.url =
      "github:nixos/nixpkgs/master"; # should be nixos-unstable once docker is fixed
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      imports = [ inputs.nixos-flake.flakeModule ];
      flake = let userName = "ved";
      in {
        nixosConfigurations = {
          hades = self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs.hostPlatform = "x86_64-linux";
            imports = [
              { users.users.${userName}.isNormalUser = true; }
              ./common/modules
              ./linux/modules
              self.nixosModules.home-manager
              {
                home-manager.users.${userName} = {
                  imports = [ ./common/home ./linux/home ];
                  home.stateVersion = "23.05";
                };
              }
            ];
          };
        };

        darwinConfigurations = {
          apollo = self.nixos-flake.lib.mkMacosSystem {
            nixpkgs.hostPlatform = "aarch64-darwin";
            imports = [
              ./common/modules
              ./darwin/modules
              self.darwinModules_.home-manager
              {
                users.users.${userName} = {
                  name = userName;
                  home = "/Users/${userName}";
                };
                home-manager.users.${userName} = {
                  imports = [ ./common/home ./darwin/home ];
                  home.stateVersion = "23.05";
                };
              }
            ];
          };
        };
      };

      perSystem = { self', system, pkgs, lib, config, inputs', ... }: {
        nixos-flake.primary-inputs =
          [ "nixpkgs" "home-manager" "nix-darwin" "nixos-flake" ];
        packages.default = self'.packages.activate;
      };
    };
}
