{ config, pkgs, ... }:

{
  # Enable GPU support
  services.xserver.vaapiDrivers = [ pkgs.vaapiIntel ];

  nixpkgs.config.chromium = {
    enablePepperFlash = true;
    enablePepperPDF = true;
  };
}
