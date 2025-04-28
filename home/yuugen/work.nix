{ pkgsSet, ... }:

{
  home.packages = [
    pkgsSet.stable.kicad
    pkgsSet.stable.saleae-logic-2
  ];
}
