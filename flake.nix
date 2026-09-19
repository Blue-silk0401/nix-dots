{
  description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nvf.url = "github:notashelf/nvf";
	};
  	
	outputs = { self, nixpkgs, home-manager,nvf, ... }: 
		let
			system = "x86_64-linux";
		in {

		packages.${system}.default = 
		(nvf.lib.neovimConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			modules = [ ./nvf-configuration.nix ];
		}).neovim;

		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ 
			./configuration.nix 
			nvf.nixosModules.default
			];
    			};

		homeConfiguration.amper = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			modules = [ ./home.nix ];

  		};
	};
}
