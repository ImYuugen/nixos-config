{ ... }:

{
  browser = import ./browser { };
  editor = import ./editor { };
  fcitx = import ./fcitx.nix;
  media = import ./media { };
  production = import ./production { };
  shell = import ./shell { };
  terminal = import ./terminal { };
}
