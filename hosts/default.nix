{ self, system, nixpkgs, inputs, wayland, unstable, user, ... }:

let
  lib = nixpkgs.lib;
in
{
  omen = lib.nixosSystem {
    inherit system;

    specialArgs = { inherit inputs user unstable; };
    modules = [
      ./omen
      ./system.nix
      inputs.lanzaboote.nixosModules.lanzaboote
    ] ++ (
      if wayland then [
        ./omen/wayland
        inputs.hyprland.nixosModules.default
      ] else [
        ./omen/x
      ]
    ) ++ [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs unstable user; };
          users.${user} = {
            imports = [
              (import ./omen/home.nix)
            ] ++ (
              if wayland then [
                inputs.ags.homeManagerModules.default
                inputs.hyprland.homeManagerModules.default
                (import ./omen/wayland/home.nix)
              ] else [
                (import ./omen/x/home.nix)
              ]
            );
          };
        };
        nixpkgs = {
          overlays = [
            self.overlays.default
            inputs.rust-overlay.overlays.default
          ] ++ [
            inputs.picom.overlays.default
          ] ++ (import ../overlays);
        };
      }
    ];
  };
}
