rec {
  overlay = final: prev:
    let
      dirContents = builtins.readDir ./.;
      genPackage = name: {
        inherit name;
        value = final.callPackage (./. + "/${name}") { };
      };
      names = builtins.attrNames dirContents;
    in builtins.listToAttrs (map genPackage names);
}
