{ pkgsSet, ... }:

{
  home.packages = [
    (pkgsSet.stable.emacsWithPackagesFromUsePackage {
      package = pkgsSet.stable.emacs-unstable;
      config = ./emacs.el;
      extraEmacsPackages = epkgs: [
        epkgs.dashboard
        epkgs.meow
        epkgs.use-package
        epkgs.rustic
      ];
    })
  ];
  services.emacs = {
    enable = true;
    package = pkgsSet.stable.emacs-unstable;
  };
}
