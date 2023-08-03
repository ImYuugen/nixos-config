{ config, pkgs, lib, inputs, user, ... }:

{
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "omen15";
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
  };

  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  security.rtkit.enable = true;

  services = {
    openssh.enable = true;
    dbus.enable = true;
  };

  environment = {
    shells = [ pkgs.fish ];
    systemPackages = with pkgs; [
      git wget xdg-utils pciutils killall pkg-config
      neofetch powertop
      bat exa tree btop gtop
      neovim sops
      gcc clang cmake cargo libcxx luajit python3Full gdb gnumake
      nodejs efibootmgr

      ffmpeg ffmpegthumbnailer mpv ani-cli

      zip unzip p7zip rar minizip-ng
    ];
  };

  hardware.enableAllFirmware = true;


  powerManagement.powertop.enable = true;
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    #package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  system = {
    stateVersion = "23.05";
  };
}
