{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    services = {
      ollama = {
        enable = true;
        environmentVariables = {
          OLLAMA_ORIGINS = "*";
        };
        host = "0.0.0.0";
      };
    };
  };
}
