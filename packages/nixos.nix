{ inputs, ... }@flakeContext:
let
  nixosModule = { config, lib, pkgs, ... }: {
    imports = [
      inputs.self.nixosModules.docker
      inputs.self.nixosModules.nvidia
      inputs.self.nixosModules.ollama
      inputs.self.nixosModules.system
    ];
  };
in
inputs.nixos-generators.nixosGenerate {
  system = "x86_64-linux";
  format = "docker";
  modules = [
    nixosModule
  ];
}
