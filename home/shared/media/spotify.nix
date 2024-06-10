{ inputs
, pkgsSet
, ...
}:
let
  pkgs = pkgsSet.stable;
  unstable = pkgsSet.unstable;
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    spotifyPackage = unstable.spotify;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
    ];
    enabledExtensions = with spicePkgs.extensions; [
      genre
      lastfm
      playlistIcons
      songStats
    ];
  };
  services.spotifyd.enable = true;
}
