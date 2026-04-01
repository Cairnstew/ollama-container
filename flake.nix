{
  description = "Basic container flake";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  };
  nixConfig = {
    extra-substituters = [ "https://ollama-docker-cache.cachix.org" ];
    extra-trusted-public-keys = [ "ollama-docker-cache.cachix.org-1:GcJN4S1yLkht4HNSFHzC9ark4sqpUoCDr/RsgexhFiM=" ];
  };
  outputs = inputs:
    let
      flakeContext = {
        inherit inputs;
      };
    in
    {
      nixosModules = {
        docker = import ./nixosModules/docker.nix flakeContext;
        nvidia = import ./nixosModules/nvidia.nix flakeContext;
        ollama = import ./nixosModules/ollama.nix flakeContext;
        system = import ./nixosModules/system.nix flakeContext;
      };
      packages = {
        x86_64-linux = {
          nixos = import ./packages/nixos.nix flakeContext;
        };
      };
    };
}
