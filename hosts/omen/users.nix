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
      # TODO: Find a way to do this in modules directly
      ++ (lib.lists.optional config.modules.gaming.gamemode.enable "gamemode")
      ++ (lib.lists.optional config.modules.networking.networkmanager.enable "networkmanager")
      ++ (lib.lists.optional config.modules.virtualisation.docker.enable "docker")
      ++ (lib.lists.optional config.modules.virtualisation.libvirtd.enable "libvirtd");
  };
}
