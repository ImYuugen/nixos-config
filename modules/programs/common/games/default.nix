{ pkgs, config, inputs, user, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession = {
      enable = false; # true if you want to use steam deck OS ig
    };
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable

    steam # The G.O.A.T
    gamescope

    heroic # Epic Games

    prismlauncher # Minecraft

    retroarchFull

    (lutris.override {
      extraLibraries = pkgs: [
      ];
      extraPkgs = pkgs: [
      ];
    })

    playonlinux
  ];
}
