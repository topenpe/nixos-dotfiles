{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      # Anime games. Remove if undesired.
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      nvf,
      aagl,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.hanabi = nixpkgs.lib.nixosSystem {
        pkgs = pkgs;
        modules = [
          ./share/configuration.nix
          ./disko.nix

          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          nvf.nixosModules.default

          {
            home-manager.users.topenpe = import ./user/home.nix;
          }

          {
            # Anime games. Remove if undesired.
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;
            programs.sleepy-launcher.enable = true;
            programs.honkers-railway-launcher.enable = true;
            programs.anime-game-launcher.enable = true;
          }
        ];
      };
    };
}
