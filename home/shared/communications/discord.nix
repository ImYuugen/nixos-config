{ pkgsSet, ... }:
{
  home.packages = with pkgsSet.stable; [
    legcord
  ];
}
