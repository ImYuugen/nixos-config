{ self, ... }:

{
  yuugen = self.lib.home.generateHome {
    username = "yuugen";
    extraModules = [ (import ./yuugen) ];
  };
}
