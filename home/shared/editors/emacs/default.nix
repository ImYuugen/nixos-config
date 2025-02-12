{ pkgsSet, ... }:

{
  home.packages = [
    (pkgsSet.stable.emacsWithPackagesFromUsePackage {
      package = pkgsSet.stable.emacs-unstable;
      config = ./init.el;
      extraEmacsPackages =
        epkgs: with epkgs; [
          all-the-icons
          autothemer
          dashboard
          meow
          multiple-cursors
          smartparens
          use-package
        ];
    })
  ];
  services.emacs = {
    enable = true;
    package = pkgsSet.stable.emacs-unstable;
  };
}
