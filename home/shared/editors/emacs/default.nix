{ pkgsSet, ... }:

let
  emacsWithPackages = pkgsSet.stable.emacsWithPackagesFromUsePackage {
    package = pkgsSet.stable.emacs-unstable;
    config = ./config/init.el;
    extraEmacsPackages =
      epkgs: with epkgs; [
        ace-window # OK
        all-the-icons # OK
        autothemer # OK
        avy # OK
        benchmark-init
        catppuccin-theme # OK
        centaur-tabs # OK
        clipmon # NOPE
        colorful-mode # OK
        consult # OK
        dashboard # NOPE
        direnv # OK
        doom-modeline # OK
        emojify # NOPE
        flycheck # NOPE
        forge # NOPE
        highlight-thing # NOPE
        indent-bars # NOPE
        lsp-bridge # OK-ISH
        magit # NOPE
        magit-todos # NOPE
        marginalia # OK
        meow # OK
        multiple-cursors # OK-ISH
        polymode # NOPE
        projectile # NOPE
        orderless # OK
        org # OK
        org-bullets # NOPE
        org-preview-html # OK
        org-roam # NOPE
        rainbow-delimiters # NOPE
        realgud # NOPE
        smartparens # NOPE
        tempel # NOPE
        treemacs # NOPE
        use-package # OK
        vertico # OK
        ws-butler # NOPE
        zoxide # OK-ISH
      ];
  };
in
{
  services.emacs = {
    enable = true;
    package = emacsWithPackages;
    client = {
      enable = true;
    };
  };
}
