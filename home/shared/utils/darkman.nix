{ lib, ... }:
{
  services.darkman = {
    enable = true;
    settings = {
      lat = 48.87951;
      lng = 2.28513;
    };
    lightModeScripts = {
      notif = ''
        notify-send --expire-time=5000 --urgency=low "Rise and Shine Diva 💭"
      '';
      activate = ''
        export PATH="/nix/var/nix/profiles/default/bin:$PATH"
        . $HOME/.local/bin/hm-light-activate
      '';
    };
    darkModeScripts = {
      notif = ''
        notify-send --expire-time=5000 --urgency=low "The sun is setting Queen 🍵🎼"
      '';
      activate = ''
        export PATH="/nix/var/nix/profiles/default/bin:$PATH"
        . $HOME/.local/bin/hm-dark-activate
      '';
    };
  };

  home.activation.copy-activation = lib.hm.dag.entryAfter [ "reloadSystemd" ] ''
    echo "Copying activation scripts"
    activation_dir="$(dirname -- "''${BASH_SOURCE[0]}")"
    activation_dir="$(cd -- "$activation_dir" && pwd)"
    base_dir="$(basename "$activation_dir")"
    if [ -z "$base_dir" ] || [ "$base_dir" = "light" ] || [ "$base_dir" = "dark" ]; then
      warnEcho "Running in improper directory for linking activation scripts."
      noteEcho "If you are running the theme switching activation script (e.g. via darkman) you can ignore this."
    else
      local_bin_path="$HOME/.local/bin"
      mkdir -p "$local_bin_path"
      $DRY_RUN_CMD cp -f $activation_dir/specialisation/light/activate "$local_bin_path"/hm-light-activate 2>/dev/null || true
      $DRY_RUN_CMD cp -f $activation_dir/specialisation/dark/activate "$local_bin_path"/hm-dark-activate 2>/dev/null || true
    fi

    unset activation_dir base_dir
  '';
}
