{ ... }:

{
  imports = [
    (import ../../../modules/desktop/hyprland/home.nix)
  ] ++ (
    import ../../../modules/programs/wayland
  );
}
