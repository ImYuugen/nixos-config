{ pkgsSet, ... }:

{
  home.packages = with pkgsSet.stable; [
    drawpile
  ];
}
