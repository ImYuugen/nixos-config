{ pkgsSet, ... }:
let
  pkgs = pkgsSet.stable;
  dualsense-udev = pkgs.writeTextDir "etc/udev/rules.d/70-dualsensectl.rules" ''
    # PS5 DualSense controller over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess"
    # PS5 DualSense controller over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess"
    # PS5 DualSense Edge controller over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0df2", MODE="0660", TAG+="uaccess"
    # PS5 DualSense Edge controller over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*054C:0DF2*", MODE="0660", TAG+="uaccess"
  '';
in
{
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    gamemode = {
      enable = true;
    };
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  environment.systemPackages = [
    pkgs.dualsensectl
    # VR
    pkgs.opencomposite
    pkgs.wlx-overlay-s
    # ==
  ];
  services.udev.packages = [ dualsense-udev ];

  # VR
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };
  # ==
}
