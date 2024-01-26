{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;

    shellInit = ''
      fish_add_path $HOME/.cargo/bin

      set sponge_successful_exit_codes 0
      set sponge_purge_on_exit true
    '';
    interactiveShellInit = ''
      set fish_emoji_width 2
    '';

    plugins = [
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];

    shellAbbrs = {
      "..." = "cd ../..";
      "l" = "ls -la";

      "goflake" = "cd /home/yuugen/Projects/Nix/flake";

      # Git
      # log
      "glog" = "git log --graph --oneline";
      # commit
      "gcsm" = "git commit -sm";
      "gcs" = "git commit -s";
      "gcm" = "git commit -m";
      "gc" = "git commit";
      # tag
      "gtma" = "git tag -ma";
      # files
      "gtree" = "ls -Tla --git-ignore --git";
      "gls" = "git ls-files";
    };
    shellAliases = {
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
              cd $argv[(count $argv)]
              return
          end
        end
      '';
    };
  };
}
