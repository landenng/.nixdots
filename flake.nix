{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in
    {

        nixosConfigurations = {
            zephyrus = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [ ./hosts/zephyrus/configuration.nix ];
            };
        };

        homeConfigurations = {
            holo = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./hosts/zephyrus/home.nix ];
            };
        };
    };
}
