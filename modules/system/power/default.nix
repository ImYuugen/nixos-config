{ lib, ... }:

{
  auto-cpufreq = import ./auto-cpufreq.nix;
  powerManagement = import ./powerManagement.nix;
}
