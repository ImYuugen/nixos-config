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
  key = ./.;

  imports = [
    inputs.nix-doom-emacs-unstraightened.homeModule
  ];

  options.modules.programs.editors.emacs = {
    terminal = lib.mkEnableOption "emacsclient terminal support";
    daemon = lib.mkEnableOption "Emacs Daemon & Client";
    # TODO: Do this automatically
    waylandPure = lib.mkEnableOption "Enable Pure GTK";
    installOrgDeps = lib.mkEnableOption "Install tools needed for Org mode exporting";
    doom = {
      enable = lib.mkEnableOption "Doom Emacs" // {
        default = true;
      };
      configDir = lib.mkOption {
        type = lib.types.path;
        default = "~/.config/doom";
        description = "The location of the doom configuration";
      };
      localDir = lib.mkOption {
        type = lib.types.string;
        default = "~/.local/share/doom";
      };
    };
  };

  config =
    let
      emacsPackage =
        let
          eoPkgs = inputs.emacs-overlay.packages.${pkgs.system};
        in
        (pkgs.emacsPackagesFor (
          if cfg.waylandPure then eoPkgs.emacs-unstable-pgtk else eoPkgs.emacs-unstable
        )).emacsWithPackages
          (epkgs: [ ]);
    in
    {
      home.packages =
        with pkgs;
        (
          [
            (aspellWithDicts (
              ds: with ds; [
                en
                fr
                sv
              ]
            ))
          ]
          ++ lib.lists.optionals cfg.terminal [
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
          ++ lib.lists.optionals cfg.doom.enable [
            git
            ripgrep
            gnutls
            fd
            imagemagick
            zstd
          ]
        );

      programs.doom-emacs = lib.mkIf cfg.doom.enable {
        enable = lib.mkDefault true;
        doomDir = cfg.doom.configDir;
        emacs = lib.mkDefault emacsPackage;
        experimentalFetchTree = lib.mkDefault true;
      };

      services.emacs = lib.mkIf cfg.daemon {
        enable = lib.mkDefault true;
        # Doom emacs overrides the package
        package = lib.mkOverride 1500 emacsPackage;
        socketActivation.enable = lib.mkDefault true;
        startWithUserSession = lib.mkDefault "graphical";
        client.enable = lib.mkDefault true;
      };

      home.sessionPath = [ "$XDG_CONFIG_HOME/emacs/bin" ];
    };
}
