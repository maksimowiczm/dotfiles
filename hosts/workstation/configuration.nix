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

  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "workstation";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  #   openFirewall = true;
  # };

  console.keyMap = "pl2";

  environment.systemPackages = with pkgs; [
    sbctl
  ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  system.stateVersion = "26.05";
}
