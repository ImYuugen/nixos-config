{ self, ... }:

{
  imports = [
    self.homeManagerModules.programs.shells.cli.starship
  ];

  modules.programs.shells.cli.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;

    format = "$os" + "$all" + "$character";
    right_format = "$cmd_duration";

    palette = "base16";

    character = {
      vimcmd_symbol = "[](bold green)";
      vimcmd_replace_one_symbol = "[](bold blue)";
      vimcmd_replace_symbol = "[](bold blue)";
      vimcmd_visual_symbol = "[](bold purple)";
    };

    cmd_duration = {
      min_time = 100;
      format = "[ $duration]($style)";
      style = "base04";
    };

    os = {
      disabled = false;
      symbols = {
        NixOS = " ";
      };
    };
  };
}
