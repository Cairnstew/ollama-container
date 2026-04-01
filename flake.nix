{
  description = "Basic Ollama flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  nixConfig = {
    extra-substituters = [ "https://ollama-docker-cache.cachix.org" ];
    extra-trusted-public-keys = [ "ollama-docker-cache.cachix.org-1:GcJN4S1yLkht4HNSFHzC9ark4sqpUoCDr/RsgexhFiM=" ];
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations.ollama = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixosModules/docker.nix
        ./nixosModules/nvidia.nix
        ./nixosModules/ollama.nix
        ./nixosModules/system.nix
      ];
    };
  };
}