{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";

      GLFW_IM_MODULE = "ibus";
      QT_QPA_PLATFORMTHEME = "gtk3";
    };
  };
}
