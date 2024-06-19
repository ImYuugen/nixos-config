{ pkgsSet, ... }: {
  home.packages = with pkgsSet.stable; [
    (discord.override {
      withOpenASAR = true;
    })
    betterdiscordctl
  ];
}
