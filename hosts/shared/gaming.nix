{ pkgsSet, ... }: {
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = with pkgsSet.stable; [
        proton-ge-bin
      ];
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    gamemode = {
      enable = true;
    };
  };
}
