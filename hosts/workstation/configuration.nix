{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/desktop.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    autoEnrollKeys.enable = true;
    measuredBoot = {
      enable = true;
      pcrs = [
        0
        4
        7
      ];
    };
    configurationLimit = 4;
    settings = {
      default = "auto-windows";
      timeout = 3;
      editor = true;
      console-mode = "max";
    };
  };

  networking = {
    hostName = "workstation";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  console.keyMap = "pl2";

  environment.systemPackages = with pkgs; [
    sbctl
  ];

  system.stateVersion = "26.05";
}
