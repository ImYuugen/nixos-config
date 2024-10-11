{
  config,
  pkgs,
  unstable,
  ...
}: {
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Yuugen";
      userEmail = "yuugenssb@proton.me";

      aliases = {
        edit = "commit --amend --only";
        nicelog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %C(bold blue)%an%Creset %s %Cgreen(%cr)' --abbrev-commit --date=relative";
        pall = "!git remote | xargs -L1 git push --all";
        s = "status";
      };

      diff-so-fancy = {
        enable = true;
      };

      extraConfig = {
        color = {
          ui = true;
          diff-highlight = {
            oldNormal = "red bold";
            oldHighlight = "red bold 52";
            newNormal = "green bold";
            newHighlight = "green bold 22";
          };
          diff = {
            meta = "11";
            frag = "magenta bold";
            func = "146 bold";
            commit = "yellow bold";
            old = "red bold";
            new = "green bold";
            whitespace = "red reverse";
          };
        };
        init = {
          defaultBranch = "main";
        };
        pull = {
          ff = "only";
        };
        # Fuck off
        safe = {
          directory = "/home/yuugen/Projects/Nix/flake/.git";
        };
      };

      ignores = [
        "*~"
        "*.swp"
      ];
    };
    lazygit = {
      enable = true;
      # settings = {};
    };
  };
}
