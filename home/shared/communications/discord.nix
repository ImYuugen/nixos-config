{ pkgsSet, ... }: {
  home.packages = with pkgsSet.stable; [
    vesktop
  ];
}
