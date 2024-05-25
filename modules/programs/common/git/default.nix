{ config, pkgs, unstable, ... }:

{
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
      };

      hooks = {
        # TODO: Add pre-commit hook
      };

      ignores = [
        "*~"
        "*.swp"
      ];
    };

    git-cliff = {
      enable = true;
      package = unstable.git-cliff;
      settings = {
        changelog = { };
        git = {
          commit_parsers = [
            { message = "^feat"; group = "<!-- 0 -->Features"; }
            { message = "^fix"; group = "<!-- 1 -->Bug Fixes"; }
            { message = "^doc"; group = "<!-- 3 -->Documentation"; }
            { message = "^perf"; group = "<!-- 4 -->Performance"; }
            { message = "^refactor"; group = "<!-- 2 -->Refactor"; }
            { message = "^style"; group = "<!-- 5 -->Styling"; }
            { message = "^test"; group = "<!-- 6 -->Testing"; }
            { message = "^chore\\(release\\): prepare for"; skip = true; }
            { message = "^chore\\(deps.*\\)"; skip = true; }
            { message = "^chore\\(pr\\)"; skip = true; }
            { message = "^chore\\(pull\\)"; skip = true; }
            { message = "^chore|^ci"; group = "<!-- 7 -->Miscellaneous Tasks"; }
            { body = ".*security"; group = "<!-- 8 -->Security"; }
            { message = "^revert"; group = "<!-- 9 -->Revert"; }
          ];
        };
      };
    };
  };
}
