{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options.firefoxConfig.enable = lib.mkEnableOption "Enable hardened Firefox";

  config = lib.mkIf config.firefoxConfig.enable {
    programs.firefox = {
      enable = true;
      arkenfox = {
        enable = true;
        version = "master";
      };

      profiles.user = {
        isDefault = true;
        settings = {
          "dom.security.https_only_mode" = true;
          "identity.fxaccounts.enabled" = false;
          "browser.startup.homepage" = "about:blank";
          "browser.search.defaultenginename" = "searx";
          "browser.search.order.1" = "searx";
        };

        bookmarks = [
        { name = "meta"; bookmarks = [
          { name = "reiwa"; url = "https://topenpe.strangled.net"; }
          { name = "github"; url = "https://github.com"; }
          { name = "corpus"; url = "https://ruscorpora.ru"; }
          { name = "wikipedia"; url = "https://en.wikipedia.org"; }
          { name = "wiktionary"; url = "https://en.wiktionary.org"; }
          { name = "википедия"; url = "https://ru.wikipedia.org"; }
          { name = "викисловарь"; url = "https://ru.wiktionary.org"; }
        ]; }
        { name = "nix"; toolbar = true; bookmarks = [
          { name = ""; url = "https://search.nixos.org"; }
          { name = "appendix"; url = "https://nix-community.github.io/home-manager/options.xhtml"; }
          { name = "wiki"; url = "https://nixos.wiki"; }
          { name = "dev"; url = "https://nix.dev/reference/nix-manual"; }
        ]; }
        { name = "books"; bookmarks = [
          { name = "latinLibrary"; url = "https://thelatinlibrary.com/index.html"; }
        ]; }
        { name = "media"; bookmarks = [
          { name = "odysee"; url = "https://odysee.com"; }
          { name = "yewtu.be"; url = "https://yewtu.be"; }
          { name = "orpheus"; url = "https://orpheus.network"; }
          { name = "16colors"; url = "https://16colo.rs"; }
          { name = "rutracker"; url = "https://rutracker.org"; }
        ]; }
        { name = "technology"; bookmarks = [
          { name = "AF"; url = "https://alignmentforum.org"; }
        ]; }
        ];

#        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
#          tridactyl
#          ublock-origin
#          wappalyzer
#        ];

        search = {
          force = true;
          default = "searx";
          engines = {
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "searx" = {
              urls = [{ template = "https://searx.be/?q={searchTerms}"; }];
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@s" ];
            };
          };
        };
      };
    };
  };
}
