{ pkgsSet
, ...
}:
let
  pkgs = pkgsSet.stable;
in
{
  home.packages = with pkgs; [ spotify ];
  services.spotifyd.enable = true;
}
