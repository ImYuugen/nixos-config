{ pkgsSet, ... }:

{
  home.sessionVariables.BROWSER = "librewolf";

  programs.librewolf = {
    enable = true;
    languagePacks = [
      "en-US"
      "fr-FR"
      "jp-JP"
    ];
    settings = {
      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "browser.startup.page" = 3;
      "middlemouse.paste" = false;
      "general.autoScroll" = true;
      "dom.webgpu.enabled" = true;
      "dom.webgl.enabled" = true; # I know I shouldn't 😔
      "signon.storeSignons" = true;
      "signon.rememberSignons" = true;
      "signon.storeWhenAutocompleteOff" = true;
    };
  };

  programs.firefox = {
    enable = false;
    policies = {
      AppAutoUpdate = false;
      DisablePocket = true;
      DisableTelemetry = true;
      Preferences = {
        "dom.webgpu.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
      };
      TranslateEnabled = false;
    };
    profiles."Default" = {
      isDefault = true;
      search = {
        force = true; # Why is this a thing
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgsSet.unstable.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/index.php";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };
        };
      };
    };
  };
}
