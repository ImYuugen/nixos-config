{ ... }:

{
  imports = [
    ../../../modules/desktop/bspwm/home.nix
  ] ++ (
    import ../../../modules/programs/x
  );
}
