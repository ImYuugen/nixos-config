{ ... }:

{
  auto-cpufreq = import ./auto-cpufreq.nix;
  powerManagement = import ./powerManagement.nix;
  power-profiles-daemon = import ./power-profiles-daemon.nix;
}
