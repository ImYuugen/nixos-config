{
  generateHome =
    {
      username,
      homeDirectory ? "/home/${username}",
      extraModules ? [ ],
    }:
    {
      _file = ./home.nix;
      key = ./home.nix + ".${username}";
      home = {
        inherit homeDirectory username;
        stateVersion = "23.11";
      };
      imports = extraModules;
    };
}
