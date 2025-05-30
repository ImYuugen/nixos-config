{
  generateHome =
    {
      username,
      homeDirectory ? "/home/${username}",
      extraModules ? [ ],
    }:
    {
      home = {
        inherit homeDirectory username;
        stateVersion = "23.11";
      };
      imports = extraModules;
    };
}
