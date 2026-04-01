{
  description = "Basic container flake";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
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
