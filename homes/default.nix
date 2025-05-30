{ self, ... }:

let
  mkHome =
    {
      username,
      extraModules ? [ ],
    }:
    self.lib.home.generateHome { inherit username extraModules; };
in
{
  yuugen = mkHome {
    username = "yuugen";
    extraModules = [ (import ./yuugen) ];
  };
}
