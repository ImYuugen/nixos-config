{ inputs
, pkgsSet
, ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    configDir = ./config;
    extraPackages = with pkgsSet.stable; [
      nodejs
    ];
  };
}
