{
  inputs,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs.stable; [
    man-pages
    man-pages-posix
    pciutils
    glibcLocales
  ];

  security = {
    polkit.enable = true;
    rtkit.enable = true;

    sudo.enable = false;
    doas = {
      enable = true;
      extraConfig = ''
        permit nopass keepenv setenv { PATH } :wheel cmd nixos-rebuild
      '';
    };
  };

  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };
}
