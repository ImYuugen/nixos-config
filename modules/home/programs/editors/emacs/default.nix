{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.programs.editors.emacs;
in
{
  options.modules.programs.editors.emacs = {
    terminal = lib.mkEnableOption "emacsclient terminal support";
    daemon = lib.mkEnableOption "Emacs Daemon & Client";
    # TODO: Do this automatically
    waylandPure = lib.mkEnableOption "Enable Pure GTK";
    installOrgDeps = lib.mkEnableOption "Install tools needed for Org mode exporting";
  };

  config = {
    home.packages = lib.mkIf cfg.terminal (
      with pkgs;
      (
        [
          # Creates a new terminal frame, not guaranteed to work well
          (writeShellApplication {
            name = "emacsclient-term";
            text = ''
              ${config.services.emacs.package}/bin/emacsclient -t
            '';
          })

        ]
        ++ lib.lists.optionals cfg.installOrgDeps [
          # Org mode export dependencies
          # Provides LaTeX conversion tools
          tetex
          # Needed to export to ODT
          zip
        ]
      )
    );

    services.emacs = lib.mkIf cfg.daemon {
      enable = lib.mkDefault true;
      package =
        let
          eoPkgs = inputs.emacs-overlay.packages.${pkgs.system};
        in
        (pkgs.emacsPackagesFor (
          if cfg.waylandPure then eoPkgs.emacs-unstable-pgtk else eoPkgs.emacs-unstable
        )).emacsWithPackages
          (
            epkgs: with epkgs; [
              treesit-grammars.with-all-grammars
            ]
          );
      socketActivation.enable = lib.mkDefault true;
      startWithUserSession = lib.mkDefault "graphical";
      client.enable = lib.mkDefault true;
    };
  };
}
