{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Build tools
    autoconf autoconf-archive automake
    cmake gnumake meson ninja

    # Compilers
    (lib.setPrio (gcc.meta.priority + 1) gcc-unwrapped)
    llvmPackages_14.clang
    llvmPackages_14.llvm llvmPackages_14.lld
    llvmPackages_14.lldb

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
