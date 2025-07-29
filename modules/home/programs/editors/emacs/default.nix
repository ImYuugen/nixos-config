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
    enable = lib.mkEnableOption "Enable Emacs";
    terminal = lib.mkEnableOption "Emacsclient terminal support";
    doom = {
      enable = lib.mkEnableOption "Doom Emacs";
      configDir = lib.mkOption {
        type = lib.types.path;
        description = "The location of the doom configuration";
      };
    };
  };

  config = lib.mkIf cfg.enable (
    let
      emacsPackage = inputs.emacs-overlay.packages.${pkgs.system}.emacs-unstable-pgtk;
      extraPackages = epkgs: [
        pkgs.ripgrep
        pkgs.fd
        pkgs.git
      ];
    in
    lib.mkMerge [
      (lib.mkIf cfg.doom.enable {
        home.packages = with pkgs; [
          gnutls
          imagemagick
          zstd
        ];
        programs.doom-emacs = {
          inherit extraPackages;
          enable = lib.mkDefault true;
          doomDir = lib.mkDefault cfg.doom.configDir;
          emacs = lib.mkDefault emacsPackage;
          experimentalFetchTree = lib.mkDefault true;
        };
      })

      (lib.mkIf (!cfg.doom.enable) {
        services.emacs.package = (pkgs.emacsPackagesFor emacsPackage).emacsWithPackages extraPackages;
      })

      (lib.mkIf cfg.terminal {
        home.packages = [
          # Creates a new terminal frame, not guaranteed to work well
          (pkgs.writeShellApplication {
            name = "emacsclient-t";
            text = ''
              ${config.services.emacs.package}/bin/emacsclient -t
            '';
          })
        ];
      })

      # Unconditional installs
      {
        home.packages = with pkgs; [
          (aspellWithDicts (
            ds: with ds; [
              en
              fr
              sv
            ]
          ))
          tetex
          zip
        ];

        services.emacs = {
          enable = lib.mkDefault true;
          socketActivation.enable = lib.mkDefault true;
          startWithUserSession = lib.mkDefault "graphical";
          client.enable = lib.mkDefault true;
        };
      }
    ]
  );
}
