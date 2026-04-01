{ config, lib, pkgs, ... }: {
  config = {
    environment.systemPackages = [ pkgs.curlFull ];
    i18n.defaultLocale = "en_GB.UTF-8";
    system.stateVersion = "24.11";
    time.timeZone = "Europe/London";
  };
}