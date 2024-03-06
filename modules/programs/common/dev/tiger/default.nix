{ config, pkgs, ... }:

{
  home.packages = with pgks; [
    autoconf automake
    bison boost
    clang32-alias
    flex reflex
    gnum4 gnumake
    libtool libxslt llvmPackages_14.llvm
    perl
  ]
}
