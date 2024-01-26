{ ... }:

{
  imports = [
    (import ../../../modules/desktop/bspwm/home.nix)
  ] ++ (
    import ../../../modules/programs/x
  );
}
