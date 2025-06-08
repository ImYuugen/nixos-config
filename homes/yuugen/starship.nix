{ lib, self, ... }:

let
  applyCommonArgs = builtins.mapAttrs (
    lang: set:
    set
    // {
      style = "bg:green";
      format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
    }
  );
  languages = (
    applyCommonArgs {
      # Languages
      # https://starship.rs/presets/nerd-font
      aws.symbol = "  ";
      buf.symbol = " ";
      bun.symbol = " ";
      c.symbol = " ";
      cpp.symbol = " ";
      cmake.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      deno.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fennel.symbol = " ";
      fossil_branch.symbol = " ";
      gcloud.symbol = "  ";
      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      pixi.symbol = "󰏗 ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = "󱘗 ";
      scala.symbol = " ";
      swift.symbol = " ";
      zig.symbol = " ";
      gradle.symbol = " ";
      docker_context.symbol = " ";
      conda = {
        symbol = " ";
        ignore_base = false;
      };
    }
  );
  languageNames = builtins.attrNames languages;
in
{
  imports = [
    self.homeManagerModules.programs.shells.cli.starship
  ];

  modules.programs.shells.cli.starship.enable = true;
  # https://starship.rs/presets/catppuccin-powerline
  programs.starship.settings = languages // {
    "$schema" = "https://starship.rs/config-schema.json";
    format =
      "[](red)"
      + "$os"
      + "[](bg:peach fg:red)"
      + "$directory"
      + "$direnv"
      + "[](bg:yellow fg:peach)"
      + "$git_branch"
      + "$git_status"
      + "[](fg:yellow bg:green)"
      + (lib.lists.foldr (lang: acc: "\$${lang}" + acc) "" languageNames)
      + "[](fg:green bg:lavender)"
      + "$time"
      + "[ ](fg:lavender)"
      + "$jobs"
      + "$cmd_duration"
      + "$line_break"
      + "$character";
    palette = "catppuccin_mocha";
    os = {
      disabled = false;
      style = "bg:red fg:crust";
    };
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
    directory = {
      style = "bg:peach fg:crust";
      format = "[ $path $read_only ]($style)";
      truncation_length = 4;
      truncation_symbol = ".../";
      truncate_to_repo = true;
      read_only = " 󰌾";
    };
    direnv = {
      disabled = false;
      style = "bg:peach fg:crust";
      loaded_msg = "L";
      unloaded_msg = "U";
      allowed_msg = "V";
      not_allowed_msg = "X";
      format = "[$loaded/$allowed ]($style)";
    };
    git_branch = {
      symbol = "";
      style = "bg:yellow";
      format = "[[ $symbol $branch ](fg:crust bg:yellow)]($style)";
    };
    git_status = {
      style = "bg:yellow";
      format = "[[$all_status $ahead_behind ](fg:crust bg:yellow)]($style)";
      conflicted = "[⇌\${count}](bold fg:crust bg:yellow)";
      ahead = "[⇡\${count}](bold fg:crust bg:yellow)";
      behind = "[⇣\${count}](bold fg:crust bg:yellow)";
      diverged = "[⇕\${ahead_count}|▿\${behind_count}](fg:crust bg:yellow)";
      untracked = "[◌\${count}](italic fg:crust bg:yellow)";
      stashed = "[󰜦\${count}](italic fg:crust bg:yellow)";
      modified = "[~\${count}](italic fg:crust bg:yellow)";
      staged = "[◈\${count}](bold fg:crust bg:yellow)";
      renamed = "[ \${count}](italic fg:crust bg:yellow)";
      deleted = "[✕\${count}](italic fg:crust bg:yellow)";
    };
    jobs = {
      disabled = false;
      style = "fg:green";
      symbol = " ";
      format = "[$symbol$number ]($style)";
    };
    time = {
      disabled = false;
      time_format = "%R";
      style = "bg:lavender";
      format = "[[  $time ](fg:crust bg:lavender)]($style)";
    };
    line_break = {
      disabled = false;
    };
    character = {
      disabled = false;
      success_symbol = "[❯](bold fg:green)";
      error_symbol = "[❯](bold fg:red)";
    };
    cmd_duration = {
      disabled = false;
      show_milliseconds = true;
      format = " in $duration ";
      style = "bg:lavender";
      show_notifications = true;
      min_time_to_notify = 45000;
    };

    palettes.catppuccin_mocha = {
      rosewater = "#f5e0dc";
      flamingo = "#f2cdcd";
      pink = "#f5c2e7";
      mauve = "#cba6f7";
      red = "#f38ba8";
      maroon = "#eba0ac";
      peach = "#fab387";
      yellow = "#f9e2af";
      green = "#a6e3a1";
      teal = "#94e2d5";
      sky = "#89dceb";
      sapphire = "#74c7ec";
      blue = "#89b4fa";
      lavender = "#b4befe";
      text = "#cdd6f4";
      subtext1 = "#bac2de";
      subtext0 = "#a6adc8";
      overlay2 = "#9399b2";
      overlay1 = "#7f849c";
      overlay0 = "#6c7086";
      surface2 = "#585b70";
      surface1 = "#45475a";
      surface0 = "#313244";
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";
    };

    palettes.catppuccin_frappe = {
      rosewater = "#f2d5cf";
      flamingo = "#eebebe";
      pink = "#f4b8e4";
      mauve = "#ca9ee6";
      red = "#e78284";
      maroon = "#ea999c";
      peach = "#ef9f76";
      yellow = "#e5c890";
      green = "#a6d189";
      teal = "#81c8be";
      sky = "#99d1db";
      sapphire = "#85c1dc";
      blue = "#8caaee";
      lavender = "#babbf1";
      text = "#c6d0f5";
      subtext1 = "#b5bfe2";
      subtext0 = "#a5adce";
      overlay2 = "#949cbb";
      overlay1 = "#838ba7";
      overlay0 = "#737994";
      surface2 = "#626880";
      surface1 = "#51576d";
      surface0 = "#414559";
      base = "#303446";
      mantle = "#292c3c";
      crust = "#232634";
    };

    palettes.catppuccin_latte = {
      rosewater = "#dc8a78";
      flamingo = "#dd7878";
      pink = "#ea76cb";
      mauve = "#8839ef";
      red = "#d20f39";
      maroon = "#e64553";
      peach = "#fe640b";
      yellow = "#df8e1d";
      green = "#40a02b";
      teal = "#179299";
      sky = "#04a5e5";
      sapphire = "#209fb5";
      blue = "#1e66f5";
      lavender = "#7287fd";
      text = "#4c4f69";
      subtext1 = "#5c5f77";
      subtext0 = "#6c6f85";
      overlay2 = "#7c7f93";
      overlay1 = "#8c8fa1";
      overlay0 = "#9ca0b0";
      surface2 = "#acb0be";
      surface1 = "#bcc0cc";
      surface0 = "#ccd0da";
      base = "#eff1f5";
      mantle = "#e6e9ef";
      crust = "#dce0e8";
    };

    palettes.catppuccin_macchiato = {
      rosewater = "#f4dbd6";
      flamingo = "#f0c6c6";
      pink = "#f5bde6";
      mauve = "#c6a0f6";
      red = "#ed8796";
      maroon = "#ee99a0";
      peach = "#f5a97f";
      yellow = "#eed49f";
      green = "#a6da95";
      teal = "#8bd5ca";
      sky = "#91d7e3";
      sapphire = "#7dc4e4";
      blue = "#8aadf4";
      lavender = "#b7bdf8";
      text = "#cad3f5";
      subtext1 = "#b8c0e0";
      subtext0 = "#a5adcb";
      overlay2 = "#939ab7";
      overlay1 = "#8087a2";
      overlay0 = "#6e738d";
      surface2 = "#5b6078";
      surface1 = "#494d64";
      surface0 = "#363a4f";
      base = "#24273a";
      mantle = "#1e2030";
      crust = "#181926";
    };
  };
}
