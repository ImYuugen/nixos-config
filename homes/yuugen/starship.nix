{ self, ... }:

{
  imports = [
    self.homeManagerModules.programs.cli.starship
  ];

  modules.programs.cli.starship.enable = true;
  programs.starship.settings =
    let
      nerdfonts = {
        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CachyOS = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          Nobara = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };

        aws = {
          symbol = "  ";
        };

        buf = {
          symbol = " ";
        };

        bun = {
          symbol = " ";
        };

        c = {
          symbol = " ";
        };

        cpp = {
          symbol = " ";
        };

        cmake = {
          symbol = " ";
        };

        conda = {
          symbol = " ";
        };

        crystal = {
          symbol = " ";
        };

        dart = {
          symbol = " ";
        };

        deno = {
          symbol = " ";
        };

        docker_context = {
          symbol = " ";
        };

        elixir = {
          symbol = " ";
        };

        elm = {
          symbol = " ";
        };

        fennel = {
          symbol = " ";
        };

        fossil_branch = {
          symbol = " ";
        };

        gcloud = {
          symbol = "  ";
        };

        git_commit = {
          tag_symbol = "  ";
        };

        golang = {
          symbol = " ";
        };

        guix_shell = {
          symbol = " ";
        };

        haskell = {
          symbol = " ";
        };

        haxe = {
          symbol = " ";
        };

        hg_branch = {
          symbol = " ";
        };

        java = {
          symbol = " ";
        };

        julia = {
          symbol = " ";
        };

        kotlin = {
          symbol = " ";
        };

        lua = {
          symbol = " ";
        };

        memory_usage = {
          symbol = "󰍛 ";
        };

        meson = {
          symbol = "󰔷 ";
        };

        nim = {
          symbol = "󰆥 ";
        };

        nix_shell = {
          symbol = " ";
        };

        nodejs = {
          symbol = " ";
        };

        ocaml = {
          symbol = " ";
        };

        package = {
          symbol = "󰏗 ";
        };

        perl = {
          symbol = " ";
        };

        php = {
          symbol = " ";
        };

        pijul_channel = {
          symbol = " ";
        };

        pixi = {
          symbol = "󰏗 ";
        };

        python = {
          symbol = " ";
        };

        rlang = {
          symbol = "󰟔 ";
        };

        ruby = {
          symbol = " ";
        };

        rust = {
          symbol = "󱘗 ";
        };

        scala = {
          symbol = " ";
        };

        swift = {
          symbol = " ";
        };

        zig = {
          symbol = " ";
        };

        gradle = {
          symbol = " ";
        };
      };
    in
    {
      format =
        "$os"
        + "$directory"
        + "$direnv"
        + "$git_branch"
        + "$git_status"
        + "$all"
        + "$cmd_duration"
        + "$line_break"
        + "$jobs"
        + "$username$hostname"
        + "$character";

      right_format = "$time";

      add_newline = false;

      username = {
        show_always = true;
        style_root = "bold fg:red";
        style_user = "fg:blue";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = true;
        style = "fg:purple";
        format = "[@$hostname]($style)";
        ssh_symbol = " ";
      };

      battery = {
        disabled = true;
      };

      directory = {
        style = "fg:orange";
        truncation_length = 4;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        format = "[[$read_only]($read_only_style)  $path]($style) ";
        read_only = " 󰌾";
        read_only_style = "fg:orange";
      };

      direnv = {
        disabled = false;
        style = "bold fg:orange";
        loaded_msg = "󰛢";
        unloaded_msg = "󰛣";
        allowed_msg = "";
        not_allowed_msg = "󰂭 ";
        denied_msg = "󰂭 ";
        format = "[$allowed$loaded ]($style) ";
      };

      git_branch = {
        style = "fg:green";
        symbol = " ";
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };

      git_status = {
        style = "fg:yellow";
        format = "[$all_status$ahead_behind]($style) ";
        conflicted = " ⇌$count";
        ahead = " ⇡$count";
        behind = " ⇣$count";
        diverged = " ⇡$ahead_count | ⇣$behind_count";
        untracked = " ◌ $count";
        stashed = " ∅ $count";
        modified = " ○ $count";
        staged = " ● $count";
        renamed = "  $count";
        deleted = " ✕ $count";
      };

      jobs = {
        format = "$symbol$number ";
      };

      character = {
        success_symbol = "[ ](bold green)";
        error_symbol = "[ ](bold red)";
        vimcmd_symbol = "[ ](bold green)";
        vimcmd_replace_one_symbol = "[ ](bold blue)";
        vimcmd_replace_symbol = "[ ](bold blue)";
        vimcmd_visual_symbol = "[ ](bold purple)";
      };

      cmd_duration = {
        disabled = false;
        min_time = 1000;
        format = "[ took $duration]($style)";
        style = "base03";
      };

      time = {
        disabled = false;
        time_format = "%T";
        style = "fg:base05";
        format = "[$time ]($style)";
      };

      os = {
        disabled = false;
        format = "[$symbol ]($style) ";
        style = "fg:base04";
      };

    }
    // nerdfonts;
}
