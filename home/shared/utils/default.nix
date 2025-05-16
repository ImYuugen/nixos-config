{ config, pkgsSet, ... }:
{
  imports = [ ./btop.nix ];

  home.packages = with pkgsSet.unstable; [
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.fr-any
    hunspellDicts.sv-se
    protonvpn-gui
    qbittorrent-enhanced
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-fuse
    kdePackages.kio-extras
  ];

  home.sessionVariables.DICPATH = "${config.home.profileDirectory}/share/hunspell";

  services = {
    blueman-applet.enable = true;
    gnome-keyring.enable = true;
  };

  programs = {
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
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
