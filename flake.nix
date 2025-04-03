{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-colors.url = "github:misterio77/nix-colors";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixvim,
      home-manager,
      hyprpanel,
      ...
    }:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      hanabi = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ inputs.hyprpanel.overlay ];
          config = {
            allowUnfree = true;
          };
        };

        specialArgs = {
          inherit (self) system inputs outputs;
        };

        modules = [ 

          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager

          { home-manager = {
             extraSpecialArgs = {
               inherit (self) system inputs outputs;
             };
             users.topenpe = import ./home-manager/home.nix;
             backupFileExtension = "backup";
           };
          }
        ];
      };
    };
  };
}
