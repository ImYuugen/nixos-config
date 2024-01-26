rec {
  overlay = final: prev:
    let
      genPackage = name: {
        inherit name;
        value = final.callPackage (./. + "/${name}") { };
      };
      names = builtins.attrNames (builtins.readDir ./.);
    in builtins.listToAttrs (map genPackage names);
}
