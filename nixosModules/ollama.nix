{ config, lib, pkgs, ... }: {
  config = {
    services.ollama = {
      enable = true;
      host = "0.0.0.0";
      environmentVariables = {
        OLLAMA_ORIGINS = "*";
      };
    };
  };
}