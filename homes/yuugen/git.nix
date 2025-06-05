{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tig
  ];

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Yuugen";
      userEmail = "yuugenssb@proton.me";

      aliases = {
        edit = "commit --amend --only";
        # Log Nice
        ln = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %C(bold blue)%an%Creset %s %Cgreen(%cr)' --abbrev-commit --date=relative";
        # Log Diff
        ld = "log --graph --oneline --abbrev-commit --decorate --stat --format=format:'%C(bold blue)%h%C(reset) - %C(green)(%ar)%C(reset) %C(white)%s%C(reset) %C(italic red)- %an%C(reset)%C(bold green)%d%C(reset)'";
        pushall = "!git remote | xargs -L1 git push";
        s = "status";
      };

      diff-so-fancy = {
        enable = true;
      };

      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          ff = "only";
        };

        # PLEASE FIX THIS UPSTREAM PEOPLE
        safe.directory = "*";
      };
      ignores = [
        "*~"
        "*.swp"
        "#*"
      ];
    };
    lazygit = {
      enable = true;
    };
  };
}
