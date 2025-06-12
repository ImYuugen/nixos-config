{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.programs.editors.emacs;
in
{
  options.modules.programs.editors.emacs = {
    terminal = lib.mkEnableOption "Emacs";
    daemon = lib.mkEnableOption "Emacs Daemon & Client";
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
      socketActivation.enable = lib.mkDefault true;
      startWithUserSession = lib.mkDefault "graphical";
      client = {
        enable = lib.mkDefault true;
      };
    };
  };
}
