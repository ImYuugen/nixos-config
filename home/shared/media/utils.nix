{ pkgsSet
, ...
}: {
  services.playerctld.enable = true;
  home.packages = with pkgsSet.stable; [ playerctl ];
}
