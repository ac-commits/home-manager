{ config, pkgs, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        DisableTelemetry = true;

        /* ---- EXTENSIONS ---- */
        ExtensionSettings = {
          # Bitwarden:
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
          # DF YouTube:
          "dfyoutube@example.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/df-youtube/latest.xpi";
            installation_mode = "force_installed";
          };
          # Old Reddit Redirect:
          "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/old-reddit-redirect/latest.xpi";
            installation_mode = "force_installed";
          };
          # Reddit Enhancement Suite:
          "jid1-xUfzOsOFlzSOXg@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/reddit-enhancement-suite/latest.xpi";
            installation_mode = "force_installed";
          };
          # SponsorBlock:
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
          };
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Vimium:
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            installation_mode = "force_installed";
          };
          # Zotero:
          "zotero@chnm.gmu.edu" = {
            install_url = "https://www.zotero.org/download/connector/dl?browser=firefox&version=5.0.147";
            installation_mode = "force_installed";
          };
        };

        /* ---- PREFERENCES ---- */
        Preferences = {
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "signon.rememberSignons" = lock-false; # Disable password prompts

          # Set DuckDuckGo as the default search engine
          "browser.search.defaultenginename" = { Value = "DuckDuckGo"; Status = "locked"; };

          # Set homepage to a custom local HTML file
          "browser.startup.homepage" = { Value = "file:///home/alex/.config/home-manager/homepage/homepage.html"; Status = "locked"; };

          # Set new tab page to match the homepage
          "browser.newtabpage.enabled" = lock-true;
          "browser.newtabpage.activity-stream.default.sites" = {
            Value = "file:///home/alex/.config/home-manager/homepage/homepage.html";
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.aboutHome.override" = {
            Value = "file:///home/alex/.config/home-manager/homepage/homepage.html";
            Status = "locked";
          };

          # Privacy and security settings
          "privacy.history.custom" = lock-true;
          "places.history.enabled" = lock-false;
          "privacy.clearOnShutdown.history" = lock-true;
          "privacy.clearOnShutdown.cookies" = lock-true;
          "privacy.clearOnShutdown.cache" = lock-true;
          "privacy.sanitize.sanitizeOnShutdown" = lock-true;
          "privacy.trackingprotection.enabled" = lock-true;
          "privacy.trackingprotection.pbmode.enabled" = lock-true;

          # Disable telemetry and other privacy-related services
          "datareporting.healthreport.uploadEnabled" = lock-false;
          "toolkit.telemetry.enabled" = lock-false;
          "toolkit.telemetry.archive.enabled" = lock-false;
          "toolkit.telemetry.updatePing.enabled" = lock-false;
          "toolkit.telemetry.bhrPing.enabled" = lock-false;
          "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
          "toolkit.telemetry.newProfilePing.enabled" = lock-false;
          "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
          "toolkit.telemetry.unified" = lock-false;
          "browser.ping-centre.telemetry" = lock-false;
          "app.shield.optoutstudies.enabled" = lock-false;
          "browser.discovery.enabled" = lock-false;
          "browser.safebrowsing.downloads.remote.enabled" = lock-false;
          "browser.safebrowsing.malware.enabled" = lock-false;
          "browser.safebrowsing.phishing.enabled" = lock-false;
        };
      };
    };

    /* ---- PROFILES ---- */
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.startup.homepage" = "about:blank"; # Default to about:blank for homepage
          # Additional profile-specific settings can be added here
        };
      };
      # Additional profiles can be added here
    };
  };
}
