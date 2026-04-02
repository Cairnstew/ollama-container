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
        maxLayers = 125;
        contents = with nixos.config; [
          # Only the packages your modules actually need at runtime
          services.ollama.package          # the ollama binary
          pkgs.dockerTools.caCertificates  # replaces your SSL_CERT_FILE env var
          pkgs.bashInteractive
          pkgs.coreutils
        ];
        config = {
          Cmd = [ "${nixos.config.services.ollama.package}/bin/ollama" "serve" ];
          Env = [
            "OLLAMA_HOST=${nixos.config.services.ollama.listenAddress}"
            
          ];
          ExposedPorts = { "11434/tcp" = {}; };
          Volumes = { "/models" = {}; };
        };
      };
    };
}