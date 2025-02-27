{ pkgsSet, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      #      waylandFrontend = true;
      addons = [ pkgsSet.stable.fcitx5-mozc ];
    };
  };
}
