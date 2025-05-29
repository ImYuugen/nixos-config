{
  config,
  lib,
  pkgsSet,
  ...
}:

{
  users.users.yuugen = {
    shell = pkgsSet.stable.bash;
    isNormalUser = true;
    extraGroups =
      [
        "video"
        "audio"
        "input"
        "wheel"
      ]
      ++ (lib.lists.optional config.modules.networking.networkmanager.enable "networkmanager")
      ++ (lib.lists.optional config.modules.gaming.gamemode.enable "gamemode");
  };
}
