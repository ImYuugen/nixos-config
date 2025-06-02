{ self, ... }:

{
  imports = with self.homeManagerModules; [
    profiles.base
    profiles.desktop.wayland.hyprland

    programs.terminals.wezterm

    ./git.nix
  ];

  modules = {
    programs = {
      terminals.wezterm.enable = true;
    };
  };

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, Return, exec, $TERMINAL"
  ];
}
