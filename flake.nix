{
  description = "A very basic flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-config = {
      url = "github:jctemp/.vsvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "temple";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      homeConfigurations = {
        ${username} = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit username;
          };
          modules = [
            "${self}/home-manager/home.nix"
            inputs.vscode-config.nixosModules.homeMangerModule
            {
              home.stateVersion = "23.05";
            }
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          git
          nix
          home-manager
          coreutils
          just
          nil
          nixpkgs-fmt
        ];
        shellHook = ''
          export NIX_CONFIG="experimental-features = nix-command flakes";
        '';
      };
    };
}
