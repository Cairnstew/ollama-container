{
  description = "Basic Ollama flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  nixConfig = {
    extra-substituters = [ "https://ollama-docker-cache.cachix.org" ];
    extra-trusted-public-keys = [ "ollama-docker-cache.cachix.org-1:GcJN4S1yLkht4HNSFHzC9ark4sqpUoCDr/RsgexhFiM=" ];
  };
  outputs = { self, nixpkgs }: 
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixosModules/docker.nix
          ./nixosModules/nvidia.nix
          ./nixosModules/ollama.nix
          ./nixosModules/system.nix
        ];
      };
    in
    {
      nixosConfigurations.ollama = nixos;
      packages.x86_64-linux.default = pkgs.dockerTools.buildLayeredImage {
        name = "ollama";
        tag = "latest";
        contents = [ nixos.config.system.build.toplevel ];
        config = {
          Cmd = [ "${nixos.config.system.build.toplevel}/init" ];
          Env = [ "SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt" ];
        };
      };
    };
}