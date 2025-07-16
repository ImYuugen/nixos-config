{ config, lib, ... }:

let
  cfg = config.modules.programs.shells.zsh;
in
{
  options.modules.programs.shells.zsh = {
    enable = lib.mkEnableOption "zsh";
    viBindings = lib.mkEnableOption "Vi keybinds";
    withOhMyZsh = lib.mkEnableOption "Oh My Zsh";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableZshIntegration = lib.mkDefault true;

    programs.zsh = {
      enable = lib.mkDefault true;
      dotDir = lib.mkDefault ".config/zsh";
      defaultKeymap = lib.mkIf cfg.viBindings (lib.mkDefault "viins");
      autosuggestion = {
        enable = lib.mkDefault true;
        strategy = lib.mkDefault [
          "history"
          "completion"
        ];
      };
      history.ignoreAllDups = lib.mkDefault true;
      historySubstringSearch.enable = lib.mkDefault true;
      oh-my-zsh = lib.mkIf cfg.withOhMyZsh {
        enable = lib.mkDefault true;
        plugins = lib.mkDefault (
          (lib.lists.optional config.modules.programs.shells.cli.fzf.enable "fzf")
          ++ (lib.lists.optional config.modules.programs.shells.cli.starship.enable "starship")
          ++ (lib.lists.optional config.modules.programs.shells.cli.zoxide.enable "zoxide")
        );
      };
      zsh-abbr = {
        enable = lib.mkDefault true;
        abbreviations = lib.mkDefault { };
        globalAbbreviations = { };
      };
    };
  };
}
