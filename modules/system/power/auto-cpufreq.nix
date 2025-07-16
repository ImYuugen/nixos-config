{ config, lib, ... }:

let
  cfg = config.modules.power.auto-cpufreq;
in
{
  options.modules.power.auto-cpufreq = {
    enable = lib.mkEnableOption "auto-cpufreq";
  };

  config = lib.mkIf cfg.enable {
    services.auto-cpufreq = {
      enable = lib.mkDefault true;
      settings = lib.mkDefault {
        # Very power-savey
        battery = {
          governor = "powersave";
          turbo = "never";
          energy_perf_bias = "13"; # Almost full power saving
          scaling_min_freq = 400000; # 400MHz
          scaling_max_freq = 2500000; # 2.5GHz
        };
        charger = {
          governor = "balanced";
          turbo = "auto";
          energy_perf_bias = "balance_performance";
        };
      };
    };
  };
}
