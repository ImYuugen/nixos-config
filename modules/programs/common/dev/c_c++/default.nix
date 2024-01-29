{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Build tools
    autoconf autoconf-archive automake
    cmake gnumake meson ninja

    # Compilers
    gcc (lib.setPrio (gcc.meta.priority + 1) gcc-unwrapped)
    llvmPackages_12.llvm llvmPackages_12.lld

    # Testing
    criterion gtest gcovr

    # Misc
    clang-tools gdb doxygen pkg-config
  ];

  home.file = {
    ".clang-format".source = ./.clang-format;
  };
}
