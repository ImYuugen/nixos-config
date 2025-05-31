{ ... }:

{
  browsers = import ./browsers { };
  editors = import ./editors { };
  fcitx = import ./fcitx.nix;
  media = import ./media { };
  production = import ./production { };
  shells = import ./shells { };
  terminals = import ./terminals { };
}
