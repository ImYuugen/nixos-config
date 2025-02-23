{ pkgsSet, ... }:

let
  emacsWithPackages = pkgsSet.stable.emacsWithPackagesFromUsePackage {
    package = pkgsSet.stable.emacs-unstable;
    config = ./config/init.el;
    extraEmacsPackages =
      epkgs: with epkgs; [
        # Editing
        avy
        colorful-mode
        emojify
        highlight-thing
        hl-todo
        indent-bars
        meow
        multiple-cursors
        rainbow-delimiters
        smartparens
        tempel

        # Org mode
        org-bullets
        org-preview-html
        org-roam

        # Programming
        elpy # Python extensions
        flycheck
        flycheck-irony
        flycheck-hl-todo
        flycheck-rust
        impatient-mode # Live web changes
        irony # C/C++ minor mode
        lua-mode # Lua extensions
        lsp-bridge # Lsp support
        tide # Typescript
        realgud # Debugger # TODO
        rmsbolt # Decompiler
        rustic # Rust extensions

        # Project/VCS
        direnv
        forge
        git-gutter
        magit
        projectile

        # UI/Navigation
        ace-window
        all-the-icons
        centaur-tabs
        dashboard
        doom-modeline
        treemacs

        # Themes
        autothemer
        catppuccin-theme

        # TBD
        clipmon # NOPE
        consult # OK
        marginalia # OK
        polymode # NOPE
        orderless # OK
        use-package
        vertico # OK
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
