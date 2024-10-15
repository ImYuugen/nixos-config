{pkgsSet, ...}: let
  pkgs = pkgsSet.stable;
in {
  imports = [./btop.nix];

  # Purely for Naelis
  home.packages = with pkgs; [
    filezilla
    remmina
    mysql-workbench
  ];

  services.gnome-keyring.enable = true;

  # HACK: Drop-in replacement for programs.direnv.silent
  home.sessionVariables.DIRENV_LOG_FORMAT = "";

  programs = {
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      git = true;
      icons = true;
    };
    fd.enable = true;
    feh.enable = true;
    fzf.enable = true;
    java.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
