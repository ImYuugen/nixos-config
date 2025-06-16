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
  };

  config = {
    home.packages = lib.mkIf cfg.terminal [
      # Creates a new terminal frame, not guaranteed to work well
      (pkgs.writeShellApplication {
        name = "emacsclient-term";
        text = ''
          ${config.services.emacs.package}/bin/emacsclient -t
        '';
      })
    ];

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
