{ pkgsSet, ... }:

{
  home.packages = [
    (pkgsSet.stable.emacsWithPackagesFromUsePackage {
      package = pkgsSet.stable.emacs-unstable;
      config = ./config/init.el;
      extraEmacsPackages =
        epkgs: with epkgs; [
          ace-window
          all-the-icons
          autothemer
          avy
          centaur-tabs
          clipmon
          colorful-mode
          dashboard
          doom-modeline
          emojify
          flycheck
          highlight-thing
          indent-bars
          lsp-bridge
          meow
          multiple-cursors
          polymode
          projectile
          rainbow-delimiters
          realgud
          smartparens
          tempel
          treemacs
          use-package
          vertico
          vertico-prescient
          ws-butler
          zoxide
        ];
    })
  ];
  services.emacs = {
    enable = true;
    package = pkgsSet.stable.emacs-unstable;
  };
}
