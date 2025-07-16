{
  lib,
  pkgs,
  ...
}:

{
  key = ./.;

  environment.systemPackages = with pkgs; [
    brightnessctl
    libnotify
    libva
    libva-utils
  ];

  fonts =
    let
      nerdfonts = with pkgs.nerd-fonts; [
        fira-code
        iosevka
        jetbrains-mono
        noto
        roboto-mono
        symbols-only
      ];
    in
    {
      enableDefaultPackages = lib.mkDefault true;
      packages =
        with pkgs;
        [
          material-design-icons
          material-symbols
          moralerspace-nf
          twemoji-color-font
        ]
        ++ nerdfonts;
      fontconfig = {
        defaultFonts = {
          monospace = [
            "Moralerspace Neon NF"
          ];
          serif = [
            "Moralerspace Xenon NF"
          ];
          sansSerif = [
            "Noto Sans"
          ];
        };
      };
    };

  xdg.portal = {
    enable = lib.mkDefault true;
    wlr.enable = lib.mkDefault true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
