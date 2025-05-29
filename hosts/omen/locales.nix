{ ... }:

let
  mkUTF8Locale = locale: "${locale}.UTF-8/UTF-8";
in
{
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    supportedLocales = builtins.map mkUTF8Locale [
      "en_CA"
      "fr_FR"
      "ja_JP"
    ];
  };

  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };
}
