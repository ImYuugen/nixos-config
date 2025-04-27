{ pkgsSet, ... }:

let
  pkgs = pkgsSet.stable;
in
{
  services.udev.packages = [ pkgs.usb-blaster-udev-rules ];

  environment.systemPackages = with pkgs; [
    ghdl-llvm
    surfer
    (quartus-prime-lite.override {
      supportedDevices = [
        "Cyclone V"
        "MAX 10 FPGA"
      ];
    })
  ];
}
