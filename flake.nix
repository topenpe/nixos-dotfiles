{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = { url = "github:nix-community/disko"; inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nvf = { url = "github:NotAShelf/nvf"; inputs.nixpkgs.follows = "nixpkgs"; };

    dms = { url = "github:duxlabs-dev/dux-shell/stable"; inputs.nixpkgs.follows = "nixpkgs"; };
    dux-files = { url = "github:duxlabs-dev/dux-files"; inputs.nixpkgs.follows = "nixpkgs"; };
    dsearch = { url = "github:duxlabs-dev/dux-search"; inputs.nixpkgs.follows = "nixpkgs"; };
    dux-greeter = { url = "github:duxlabs-dev/dux-greeter"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      nvf,
      dms,
      dux-files,
      dsearch,
      dux-greeter,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.problems.handlers."gtk+".broken = "warn";
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
          dux-greeter.nixosModules.default

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.topenpe = {
                imports = [
                  ./user/home.nix
                  dms.homeModules.dank-material-shell
                  dux-files.homeModules.dux-files
                  dsearch.homeModules.default
                ];
              };
            };
          }
        ];
      };
    };
}
