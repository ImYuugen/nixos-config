{ pkgsSet, ... }:

let
  pkgs = pkgsSet.stable;
in
{
  imports = [ ./btop.nix ];

  # Purely for Naelis
  home.packages = with pkgs; [
    filezilla
    remmina
    mysql-workbench
  ];

  services.gnome.gnome-keyring.enable = true;

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
