{
  inputs,
  lib,
  pkgsSet,
  ...
}: {
  environment.systemPackages = with pkgsSet.stable; [
    dconf
    glib
    glibcLocales
    killall
    linux-firmware
    linuxHeaders
    man-pages
    man-pages-posix
    pciutils
    wget
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

  xdg.portal = {
    enable = true;
    config.common.default = ["gtk"];
    extraPortals = with pkgsSet.stable; [
      xdg-desktop-portal-gtk
    ];
  };
}
