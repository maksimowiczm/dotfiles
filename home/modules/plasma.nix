{
  programs.elisa.enable = false;
  programs.ghostwriter.enable = false;
  programs.kate.enable = false;
  programs.konsole.enable = false;
  programs.okular.enable = false;
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
      wallpaperPictureOfTheDay = {
        provider = "bing";
      };
    };
    kscreenlocker.appearance.wallpaperPictureOfTheDay = {
      provider = "bing";
    };
    panels = [
      {
        location = "bottom";
        height = 40;
        floating = true;
        hiding = "dodgewindows";
        lengthMode = "fit";
        opacity = "translucent";
        widgets = [
          "org.kde.plasma.kickoff"
          {
            iconTasks = {
              launchers = [
                "applications:firefox.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
    shortcuts = {
      kwin."Window Close" = "Alt+Q";
      "services/com.mitchellh.ghostty.desktop"."_launch" = "Alt+C";
    };
    input.mice = [
      {
        name = "Logitech USB Receiver";
        vendorId = "046d";
        productId = "c547";
        accelerationProfile = "none";
      }
      {
        name = "Razer Razer Abyssus";
        vendorId = "1532";
        productId = "0042";
        accelerationProfile = "none";
      }
    ];
  };
}
