{
  description = "Nixvim Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      pre-commit-hooks,
      flake-parts,
      nixvim,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.pre-commit-hooks.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      flake = {
      };

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        let
          nixvimLib = nixvim.lib.${system};
          nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
            inherit pkgs;
            module = {
              imports = inputs.nixpkgs.lib.fileset.toList ./config;
            };
            extraSpecialArgs = { };
          };
        in
        {
          checks.default = nixvimLib.check.mkTestDerivationFromNvim {
            inherit nvim;
            name = "Nixvim configuration";
          };
          formatter = pkgs.nixfmt-rfc-style;

          pre-commit.settings = {
            src = nixpkgs.lib.cleanSource ./.;
            hooks = {
              nixfmt-rfc-style.enable = true;
              shellcheck.enable = true;
              statix = {
                enable = true;
                settings = {
                  ignore = [ ".direnv" ];
                  format = "stderr";
                };
              };
            };
          };

          packages.default = nvim;

          devShells.default = pkgs.mkShell {
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
            buildInputs = [
              pkgs.nil
              pkgs.statix
            ];
          };
        };
    };
}
