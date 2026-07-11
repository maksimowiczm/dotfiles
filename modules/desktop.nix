{
  services.xserver.enable = false;
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
}
