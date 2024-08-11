{
  inputs = {
    ags.url = "github:Aylur/ags";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    bibata-modern-classic-hyprcursor.url = "github:javigomezo/bibata-modern-classic-hyprcursor";
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
      ...
    }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        hanabi = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit (self) system inputs outputs;
          };
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit (self) system inputs outputs;
              };
              home-manager.users.topenpe = import ./home-manager/home.nix;
              home-manager.backupFileExtension = "backup";
            }
            nixvim.nixosModules.nixvim
          ];
        };
      };
    };
}
