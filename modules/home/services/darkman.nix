{
  config,
  lib,
  osConfig ? { },
  pkgs,
  ...
}:

let
  cfg = config.modules.services.darkman;
in
{
  key = ./darkman.nix;

  options.modules.services.darkman = with lib.types; {
    enable = lib.mkEnableOption "Darkman";
    stylixIntegration = {
      enable = lib.mkEnableOption "Stylix integration";
      light = {
        base16Scheme = lib.mkOption {
          type = oneOf [
            path
            lines
            attrs
          ];
        };
        image = lib.mkOption {
          type = nullOr path;
        };
      };
      dark = {
        base16Scheme = lib.mkOption {
          type = oneOf [
            path
            lines
            attrs
          ];
        };
        image = lib.mkOption {
          type = nullOr path;
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.darkman = {
        enable = lib.mkDefault true;
        settings = {
          usegeoclue = lib.mkDefault (osConfig != { } && osConfig.services.geoclue2.enable);
        };

        lightModeScripts = {
          notify = ''
            ${pkgs.libnotify}/bin/notify-send --expire-time=5000 --urgency=low "Wind up diva 🍵"
          '';
          activate-hm = ''
            export PATH="/nix/var/nix/profiles/default/bin:$PATH"
            . ${config.home.homeDirectory}/.local/bin/hm-light-activate
          '';
        };
        darkModeScripts = {
          notify = ''
            ${pkgs.libnotify}/bin/notify-send --expire-time=5000 --urgency=low "Honk shooa, sleep on that thang"
          '';
          activate-hm = ''
            export PATH="/nix/var/nix/profiles/default/bin:$PATH"
            . ${config.home.homeDirectory}/.local/bin/hm-dark-activate
          '';
        };
      };

      home = {
        activation.copy-activation = lib.hm.dag.entryAfter [ "reloadSystemd" ] ''
          echo "Copying activation scripts"
          activation_dir="$(dirname -- "''${BASH_SOURCE[0]}")"
          activation_dir="$(cd -- "$activation_dir" && pwd)"
          base_dir="$(basename "$activation_dir")"
          if [ -z "$base_dir" ] || [ "$base_dir" = "light" ] || [ "$base_dir" = "dark" ]; then
            warnEcho "Running in improper directory for linking activation scripts."
            noteEcho "If you are running the theme switching activation script (e.g. via darkman) you can ignore this."
          else
            local_bin_path="${config.home.homeDirectory}/.local/bin"
            mkdir -p "$local_bin_path"
            $DRY_RUN_CMD cp -f $activation_dir/specialisation/light/activate "$local_bin_path"/hm-light-activate 2>/dev/null || true
            $DRY_RUN_CMD cp -f $activation_dir/specialisation/dark/activate "$local_bin_path"/hm-dark-activate 2>/dev/null || true
          fi

          unset activation_dir base_dir
        '';
        sessionPath = [ "$HOME/.local/bin" ];
      };
    })
    (lib.mkIf cfg.stylixIntegration.enable {
      specialisation = {
        light.configuration = {
          stylix = {
            inherit (cfg.stylixIntegration.light) base16Scheme image;
            polarity = "light";
          };
        };
        dark.configuration = {
          stylix = {
            inherit (cfg.stylixIntegration.dark) base16Scheme image;
            polarity = "dark";
          };
        };
      };
    })
  ];
}
