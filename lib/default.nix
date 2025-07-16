{ lib, ... }:

{
  home = import ./home.nix;

  mkIfElse =
    condition: trueBranch: falseBranch:
    lib.mkMerge [
      (lib.mkIf condition trueBranch)
      (lib.mkIf (!condition) falseBranch)
    ];
}
