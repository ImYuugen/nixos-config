{
  inputs,
  pkgsSet,
  ...
}: {
  home.packages = [
    inputs.hyprcursor
    pkgsSet.stable.hyprcursor
  ];
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgsSet.stable.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };
}
