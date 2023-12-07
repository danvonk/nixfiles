{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  inputs.home-manager.url = "github:nix-community/home-manager/release-23.11";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs }@inputs: {

    # Just one nixos setup for now
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./machines/desktop/default.nix ];
      };
      nixps = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./machines/nixps/default.nix ];
      };

    };
    #  Home Manager config for dan@desktop
    homeConfigurations = {
      "dan@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs;
        }; # Pass flake inputs to our config
        modules = [ ./home/home.nix ];
      };
    };
  };
}
