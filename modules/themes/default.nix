{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyo Night"
      package = pkgs.tokyo-night-gtk;
    };
  };
}
