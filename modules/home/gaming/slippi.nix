{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.gaming.slippi;
in
{
  options.modules.gaming.slippi = {
    enable = lib.mkEnableOption "Slippi";
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = pkgs.system == "x86_64-linux";
        message = "ssb-nix is only implemented for x86_64-linux.";
      }
    ];

    home.packages = [
      inputs.nix-ssb.packages.x86_64-linux.slippi-launcher
    ];

    xdg.configFile =
      let
        netplay = inputs.nix-ssb.packages.${pkgs.system}.slippi-netplay;
      in
      # playback = inputs.nix-ssb.packages.${pkgs.system}.slippi-playback
      {
        "Slippi Launcher/netplay/Slippi_Online-x86_64.AppImage" = {
          source = "${lib.getExe netplay}";
        };
        "Slippi Launcher/netplay/Sys" = {
          source = "${netplay.raw-zip}/Sys";
        };
        # "Slippi Launcher/playback/Slippi_Playback-x86_64.AppImage" = {};
        # "Slippi Launcher/playback/Sys" = {};
      };
  };
}
