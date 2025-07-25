{ pkgsSet, self, ... }:

{
  imports = with self.homeManagerModules; [
    gaming.dolphin-emu
    gaming.lutris
    gaming.slippi
  ];

  modules.gaming = {
    dolphin-emu.enable = true;
    lutris = {
      enable = true;
      withIcons = true;
    };
    slippi.enable = true;
  };

  home.packages = [
    pkgsSet.stable.joystickwake
    pkgsSet.unstable.olympus
  ];

  programs.mangohud = {
    enable = true;
    /*
      settings =
        let
          # Takes [a b ...] and outputs an attrset with {a=true;b=true;...}
          enableOpts = builtins.foldl' (acc: opt: acc // { "${opt}" = true; }) { };
        in
        (enableOpts [
          "arch"
          "cpu_stats"
          "fps"
          "frametime"
          "fsr"
          "gpu_stats"
          "io_read"
          "io_write"
          "ram"
          "refresh_rate"
          "vram"
          "vulkan_driver"
          "wine"
          "present_mode"
        ])
        // {
          output_folder = "$HOME/Documents/MangoHud";
          toggle_hud = "Shift_R+F12";
          # General Options
          fps_metrics = "avg,0.01";
        };
    */
  };
}
