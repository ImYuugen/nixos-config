{
  imports = [ ./btop.nix ];

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
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
