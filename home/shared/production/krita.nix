{pkgsSet, ...}: {
  home.packages = with pkgsSet.stable; [
    krita
    krita-plugin-gmic
  ];
}
