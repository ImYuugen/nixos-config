{ ... }:
let
  EN = "en_US.UTF-8/UTF-8";
  FR = "fr_FR.UTF-8/UTF-8";
  JP = "ja_JP.UTF-8/UTF-8";
in
{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      EN
      FR
      JP
    ];
  };
}
