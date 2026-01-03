{ pkgs, stateVersion, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

#  nixpkgs.config.allowUnfree = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = hostname;

  networking.wireless.enable = true;
  networking.wireless.networks = {
    "ALHN-D200" = {
      psk = "t4S7VEqp";
    };
  };

  system.stateVersion = stateVersion;
}
