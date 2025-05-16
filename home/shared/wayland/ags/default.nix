{ inputs, pkgsSet, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = [
    pkgsSet.stable.dart-sass
    pkgsSet.stable.libdbusmenu-gtk3
  ];
}
