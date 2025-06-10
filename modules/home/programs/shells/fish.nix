{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.programs.shells.fish;
in
{
  options.modules.programs.shells.fish = {
    enable = lib.mkEnableOption "My Fish config";
    viBindings = lib.mkEnableOption "Vi bindings";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableFishIntegration = lib.mkDefault true;
    home.packages = with pkgs; [
      fd
      fzf
    ];

    programs.fish = {
      enable = lib.mkDefault true;
      plugins =
        let
          mkFishPlugins = builtins.map (name: {
            inherit name;
            src = pkgs.fishPlugins.${name}.src;
          });
        in
        lib.mkDefault (mkFishPlugins [
          "fzf-fish"
          "plugin-git"
          "puffer"
          "sponge"
        ]);
      shellInit = lib.mkBefore ''
        set sponge_successful_exit_codes 0 1 2
        set sponge_allow_previously_successful true
        set sponge_purge_only_on_exit true
      '';
      interactiveShellInit = lib.mkBefore (
        ''
          set fish_greeting
        ''
        + lib.optionalString cfg.viBindings ''
          set -g fish_key_bindings fish_vi_key_bindings
        ''
      );
      shellAbbrs = {
        "gcsm" = lib.mkDefault "git commit -sm";
        "gtree" = lib.mkDefault "eza -Tla --git-ignore --git";
        "tree" = lib.mkDefault "eza -T";
      };
      shellAliases = {
        "sudo" = lib.mkDefault "doas";
        "nixamer" = lib.mkDefault "shutdown now";
      };

      functions = {
        mkcd = lib.mkDefault ''
          command mkdir $argv
          if test $status = 0
            switch $argv[(count $argv)]
              case '-*'
              case '*'
                z $argv[(count $argv)]
                return
            end
          end
        '';

        tardel = lib.mkDefault ''
          tar -xvf $argv[1] && rm $argv[1]
        '';
      };
    };
  };
}
