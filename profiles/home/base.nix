{ self, ... }:

{
  key = ./.;

  imports = [
    self.homeManagerModules.programs.editors.helix
  ];

  modules = {
    programs = {
      editors.helix.enable = true;
    };
  };
}
