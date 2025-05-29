{
  config,
  lib,
  pkgsSet,
  ...
}:

let
  cfg = config.modules.gaming.dualsense;
in
{
  options.modules.gaming.dualsense = {
    enable = lib.mkEnableOption "Dualsense";
  };

  config = lib.mkIf cfg.enable (
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
      environment.systemPackages = [ pkgs.dualsensectl ];
      services.udev.packages = [ dualsense-udev ];
    }
  );
}
