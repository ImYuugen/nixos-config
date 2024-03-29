{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Build tools
    autoconf autoconf-archive automake
    cmake gnumake meson ninja

    # Compilers
    gcc (lib.setPrio (gcc.meta.priority + 1) gcc-unwrapped)
    llvmPackages_14.llvm llvmPackages_14.lld

    # Testing
    criterion gtest gcovr valgrind

    # Misc
    clang-tools gdb doxygen pkg-config
    httplib yaml-cpp bear
  ];

  home.file = {
    ".clang-format".source = ./.clang-format;
  };
}
