{
  lib,
  pkgsSet,
  self,
  ...
}:

let
  pkgs = pkgsSet.stable;
in
{
  key = ./.;

  imports = with self.nixosModules; [
    audio
    hardware.bluetooth
    hardware.disks
    networking.networkmanager
    power.powerManagement
    power.power-profiles-daemon
    security.doas
  ];

  modules = {
    audio = {
      pipewire.enable = lib.mkDefault true;
      withDefaultPackages = lib.mkDefault true;
    };
    hardware = {
      bluetooth.enable = lib.mkDefault true;
      disks.enable = lib.mkDefault true;
    };
    networking.networkmanager.enable = lib.mkDefault true;
    power = {
      powerManagement.enable = lib.mkDefault true;
      power-profiles-daemon = {
        enable = lib.mkDefault true;
        game-performance = lib.mkDefault true;
      };
    };
    security.doas.enable = lib.mkDefault true;
  };

  environment = {
    etc.hosts.mode = "0644";
    systemPackages = with pkgs; [
      acpi
      glib
      glibcLocales
      man-pages
      man-pages-posix
      wget

      rar
      zip
      unzip
    ];
  };

  i18n =
    let
      mkUTF8Locale = locale: "${locale}.UTF-8/UTF-8";
    in
    {
      # CA because all my homies hate mm/dd/yyyy
      defaultLocale = lib.mkDefault "en_CA.UTF-8";
      supportedLocales = lib.mkDefault (
        builtins.map mkUTF8Locale [
          "en_CA"
          "fr_FR"
          "ja_JP"
        ]
      );
    };

  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = lib.mkDefault [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  programs.fish.enable = true;

  time = {
    timeZone = lib.mkDefault "Europe/Paris";
    hardwareClockInLocalTime = lib.mkDefault true;
  };
}
