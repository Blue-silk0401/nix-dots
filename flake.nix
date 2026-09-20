{
  description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nvf.url = "github:notashelf/nvf";

		quickshell = {
      			url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
		        inputs.nixpkgs.follows = "nixpkgs";
    		};

    		qml-niri = {
		        url = "github:imiric/qml-niri/main";
		        inputs.nixpkgs.follows = "nixpkgs";
		        inputs.quickshell.follows = "quickshell";
    		};
	};
  	
	outputs = { self, nixpkgs, home-manager, nvf, qml-niri, ... }: 
		let
			system = "x86_64-linux";

			nvfNeovim = (nvf.lib.neovimConfiguration {
 			    pkgs = nixpkgs.legacyPackages.${system};
 			    modules = [ ./nvf-configuration.nix ];
			  }).neovim;
		in {
			
		packages.${system}.nvf = nvfNeovim;

		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ 
			./configuration.nix 
			nvf.nixosModules.default

			home-manager.nixosModules.home-manager

    	              {
		        home-manager.useGlobalPkgs = true;
		        home-manager.useUserPackages = true;
			
			home-manager.extraSpecialArgs = {
    			  inherit nvfNeovim;
			};

      			home-manager.users.tuser = import ./home.nix;
    		       }
			];
			
			specialArgs = {
			  inherit qml-niri nvfNeovim;

			};

    			};


  		};

}
