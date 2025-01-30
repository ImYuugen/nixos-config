{ pkgsSet, ... }:
let
  pkgs = pkgsSet.stable;
in
{
  imports = [ ./btop.nix ];

  home.packages = with pkgs; [
    qbittorrent-enhanced
  ];

  services = {
    blueman-applet.enable = true;
    gnome-keyring.enable = true;
  };

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
      icons = "auto";
    };
    fd.enable = true;
    feh.enable = true;
    fzf.enable = true;
    java.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
