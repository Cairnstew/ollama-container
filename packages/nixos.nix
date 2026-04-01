{ inputs, ... }@flakeContext:
let
  nixpkgs = inputs.nixpkgs;
  nixosModule = { config, lib, pkgs, ... }: {
    imports = [
      inputs.self.nixosModules.docker
      inputs.self.nixosModules.nvidia
      inputs.self.nixosModules.ollama
      inputs.self.nixosModules.system
    ];
  };
in
(nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    nixosModule
    "${nixpkgs}/nixos/modules/virtualisation/docker-image.nix"
  ];
}).config.system.build.dockerImage