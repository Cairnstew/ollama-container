{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    hardware = {
      nvidia-container-toolkit = {
        enable = true;
        suppressNvidiaDriverAssertion = true;
      };
    };
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
    services = {
      ollama = {
        package = pkgs.ollama-cuda;
      };
    };
  };
}
