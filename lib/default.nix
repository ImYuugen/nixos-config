{ lib, ... }:

{
  mkIfElse =
    condition: trueBranch: falseBranch:
    lib.mkMerge [
      (lib.mkIf condition trueBranch)
      (lib.mkIf (!condition) falseBranch)
    ];
}
