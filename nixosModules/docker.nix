{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    boot = {
      isContainer = true;
      loader = {
        initScript = {
          enable = true;
        };
      };
      tmp = {
        useTmpfs = true;
      };
    };
    networking = {
      useDHCP = true;
      useNetworkd = true;
    };
  };
}
