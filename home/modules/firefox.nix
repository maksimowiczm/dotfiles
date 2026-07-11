{
  programs.firefox = {
    enable = true;
    policies = {
      AIControls = {
        Default = {
          Locked = true;
          Value = "blocked";
        };
      };
      DisableRemoteImprovements = true;
      DisableTelemetry = true;
      DNSOverHTTPS = {
        Locked = true;
        Enabled = true;
        ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
        Fallback = false;
      };
      EnableTrackingProtection = {
        Locked = true;
        Category = "strict";
        BaselineExceptions = true;
        ConvenienceExceptions = false;
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          private_browsing = true;
        };
      };
      FirefoxHome = {
        Locked = true;
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Highlights = true;
        Pocket = false;
        SponsoredPocket = false;
        Stories = false;
        SponsoredStories = false;
        Snippets = false;
      };
      Homepage = {
        StartPage = "previous-session";
      };
      HttpsOnlyMode = "force_enabled";
    };
  };
}
