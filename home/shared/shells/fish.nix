{ pkgsSet, ... }:
let
  pkgs = pkgsSet.stable;
in
{
  programs.fish = {
    enable = true;

    shellInit = ''
      fish_add_path $HOME/.cargo/bin

      set sponge_successful_exit_codes 0
      set sponge_purge_on_exit true
    '';
    interactiveShellInit = ''
      set fish_greeting
      set fish_emoji_width 2
    '';

    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z;
      }
    ];

    shellAbbrs = {
      "..." = "z ../..";
      "l" = "ls -la";

      "goflake" = "z $HOME/Projects/Nix/flake";
      "nix-fish" = "nix-shell --run fish";
      "dev-fish" = "nix develop -c fish";
      "shell-fish" = "nix shell -c fish";
      "update" = "doas nixos-rebuild switch --flake .#";

      # Git
      # log
      "glog" = "git nicelog";
      # commit
      "gcsm" = "git commit -sm";
      "gc" = "git commit";
      # tag
      "gtma" = "git tag -ma";
      # files
      "gtree" = "ls -Tla --git-ignore --git";
      "gls" = "git ls-files";
    };
    shellAliases = {
      "tree" = "eza -T --color=always --icons";
      "ls" = "eza --color=always --icons --group-directories-first";
      "sudo" = "doas";
      "nixamer" = "shutdown now";
    };

    functions = {
      mkcd = ''
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

      tardel = ''
        tar -xvf $argv[1]
        rm $argv[1]
      '';

      reboot-windows = ''
        systemctl reboot --boot-loader-entry=auto-windows
      '';

      reboot-bios = ''
        systemctl reboot --firmware-setup
      '';

      dup = ''
        $TERMINAL . & disown
      '';
    };
  };
}
