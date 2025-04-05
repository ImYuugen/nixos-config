{ pkgsSet, ... }:

{
  home.sessionVariables.BROWSER = "firefox";

  programs.librewolf = {
    enable = false;
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
    enable = true;
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
  };
}
