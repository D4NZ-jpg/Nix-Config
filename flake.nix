{
  description = "My system configuration";
  inputs = {
    # monorepo w/ recipes ("derivations")
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # manages configs
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # system-level software and settings (macOS)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # declarative homebrew management
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    
    # dotfiles repository
    dotfiles.url = "github:D4NZ-jpg/dotfiles";
    dotfiles.flake = false;
  };

  outputs =
    {
      self,
      darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      dotfiles,
      ...
    }@inputs:
    let
      primaryUser = "dan";
    in
    {
      # build darwin flake using:
      # $ darwin-rebuild build --flake .#<name>
      darwinConfigurations."macbook" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin
          ./hosts/macbook/configuration.nix
        ];
        specialArgs = { inherit inputs self primaryUser dotfiles; };
      };
      
      # Expose dotfiles path for use in modules
      dotfilesPath = inputs.dotfiles.outPath;

    };
}
