{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.power.power-profiles-daemon;
  game-performance = pkgs.writeShellScriptBin "game-performance" ''
    # Helper script to enable the performance gov with proton or others
    if ! command -v powerprofilesctl &>/dev/null; then
        echo "Error: powerprofilesctl not found" >&2
        exit  1
    fi

    # Don't fail if the CPU driver doesn't support performance power profile
    if ! powerprofilesctl list | grep -q 'performance:'; then
        exec "$@"
    fi

    # Set performance governors, as long the game is launched
    exec systemd-inhibit --why "game-performance is running" powerprofilesctl \
      launch -p performance -r "Launched with game-performance utility" -- "$@"
  '';
in
{
  options.modules.power.power-profiles-daemon = {
    enable = lib.mkEnableOption "power-profiles-daemon";
    game-performance = lib.mkEnableOption "game-performance helper script";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.mkIf cfg.game-performance [ game-performance ];
    services = {
      power-profiles-daemon = {
        enable = lib.mkDefault true;
      };
      upower.enable = lib.mkDefault true;
    };
  };
}
