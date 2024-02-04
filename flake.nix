{
    description = "holo's flake";

    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs/nixos-unstable";
        };

        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
            systemSettings = {
                system = "x86_64-linux";
                hostname = "snow";
                host = "zephyrus";
                timezone = "America/Chicago";
                locale = "en_US.UTF-8";
            };

            userSettings = rec {
                username = "holo";
                name = "Landen";
                nixdotsDir = "~/.nixdots";
                wm = "i3";
                wmType = if (wm == "hyprland") then "wayland" else "x11";
                browser = "firefox";
                term = "alacritty";
                editor = "nvim";
            };

            # pkgs = import nixpkgs {
            #     system = systemSettings.system;
            #     config = { allowunfree = true; };
            # };

            pkgs = nixpkgs.legacyPackages.${systemSettings.system};
        in
    {
        nixosConfigurations = {
            system = nixpkgs.lib.nixosSystem {
                system = systemSettings.system;
                modules = [ (./. + "/hosts"+("/"+systemSettings.host)+"/configuration.nix") ];
                specialArgs = {
                    inherit systemSettings;
                    inherit userSettings;
                };
            };
        };

        homeConfigurations = {
            user = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ (./. + "/hosts"+("/"+systemSettings.host)+"/home.nix") ];
                extraSpecialArgs = {
                    inherit systemSettings;
                    inherit userSettings;
                };
            };
        };
    };
}
