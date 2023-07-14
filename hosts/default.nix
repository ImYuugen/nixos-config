{ system, self, nixpkgs, inputs, user, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  omen15 = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./system.nix
      #./omen15/wayland
      ./omen15/xorg
    ] ++ [
      #inputs.hyprland.nixosModules.default
      inputs.nur.nixosModules.nur
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };
          users.${user} = {
            imports = [
              (import ./omen15/xorg/home.nix)
            ] ++ [
              #inputs.hyprland.homeManagerModules.default
            ];
          };
        };
        nixpkgs = {
          overlays = [
            self.overlays.default
            inputs.rust-overlay.overlays.default
            inputs.picom.overlays.default
            inputs.nil.overlays.default
            inputs.joshuto.overlays.default
            inputs.nixd.overlays.default
          ] ++ (import ../overlays);
        };
      }
    ];
  };
}
