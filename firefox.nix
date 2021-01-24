{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      settings = {
        "browser.formfill.enable" = false;
        "browser.newtabpage.enabled" = false;
        "browser.search.isUS" = false;
        "browser.search.region" = "GB";
        "browser.search.suggest.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        "distribution.searchplugins.defaultLocale" = "en-GB";
        "dom.event.clipboardevents.enabled" = false;
        "general.autoScroll" = true;
        "general.useragent.locale" = "en-GB";
        "geo.enabled" = false;
        #"media.eme.enabled" = false; DRM video
        "media.eme.enabled" = true;
        "media.navigator.enabled" = false;
        "media.peerconnection.enabled" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.cookie.lifetimePolicy" = 2;
        "network.dns.disablePrefetch" = true;
        "network.prefetch-next" = false;
        "places.history.enabled" = false;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.cookies" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.offlineApps" = true;
        "privacy.clearOnShutdown.openWindows" = true;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.clearOnShutdown.siteSettings" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.firstparty.isolate" = true;
        "privacy.history.custom" = false;
        "privacy.resistFingerprinting" = true;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "signon.rememberSignons" = false;
        "webgl.disabled" = true;
      };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      https-everywhere
      privacy-badger
      ublock-origin
      bitwarden
      decentraleyes
    ];
  };
}
