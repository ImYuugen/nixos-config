{ pkgs, config, inputs, user, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession = {
      #enable = true;
    };
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull # Should not be in common but fuck off

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
  ];
}
