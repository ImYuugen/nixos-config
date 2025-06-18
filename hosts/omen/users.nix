{
  config,
  inputs,
  lib,
  pkgsSet,
  self,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs pkgsSet self;
    };
    users.yuugen = {
      imports = [ self.homeConfigurations.yuugen ];
    };
  };

  users.users.yuugen = {
    shell = pkgsSet.stable.fish;
    # Let the user set their own password :3
    initialPassword = "";
    isNormalUser = true;
    extraGroups =
      [
        "video"
        "audio"
        "input"
        "dialout"
        "wheel"
      ]
      # TODO: Find a way to do this in modules directly
      ++ (lib.lists.optional config.modules.gaming.gamemode.enable "gamemode")
      ++ (lib.lists.optional config.modules.networking.networkmanager.enable "networkmanager")
      ++ (lib.lists.optional config.modules.virtualisation.docker.enable "docker")
      ++ (lib.lists.optional config.modules.virtualisation.libvirtd.enable "libvirtd");
  };
}
