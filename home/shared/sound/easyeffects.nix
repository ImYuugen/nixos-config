{ pkgsSet, ... }:
{
  home.packages = [ pkgsSet.stable.easyeffects ];

  xdg.configFile = {
    "easyeffects/output/PerfectEQ.json".source = ./effects/PerfectEQ.json;
    "easyeffects/output/AdvAutoGain.json".source = ./effects/AdvAutoGain.json;
  };
}
