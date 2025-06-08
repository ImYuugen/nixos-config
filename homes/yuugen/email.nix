{ self, ... }:

{
  imports = [
    self.homeManagerModules.programs.communications.thunderbird
  ];

  modules.programs.communications.thunderbird.enable = true;

  # TODO: Add email accounts
}
