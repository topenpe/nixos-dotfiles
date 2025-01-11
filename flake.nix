{
  inputs = {
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:/anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-colors.url = "github:misterio77/nix-colors";

    nur.url = "github:nix-community/NUR";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.arkenfox.inputs.nixpkgs.follows = "nixpkgs";
    };

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
      aagl,
      anyrun,
      arkenfox,
      nixpkgs,
      nixvim,
      nur,
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

          inputs.arkenfox.hmModules.default

          home-manager.nixosModules.home-manager

          { imports = [ aagl.nixosModules.default ];
            programs.honkers-railway-launcher.enable = true;
          }

          { home-manager = {
             extraSpecialArgs = {
               inherit (self) system inputs outputs;
             };
             users.topenpe = import ./home-manager/home.nix;
             backupFileExtension = "backup";
           };
          }

          nur.nixosModules.nur
        ];
      };
    };
  };
}
