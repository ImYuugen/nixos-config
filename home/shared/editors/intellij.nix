{ pkgsSet, ... }:

{
  home.packages = with pkgsSet.stable; [
    jetbrains.idea-ultimate
    jetbrains.rust-rover
  ];
}
