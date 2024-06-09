{pkgsSet, ...}: {
  home.packages = [pkgsSet.stable.easyeffects];

  xdg.configFile = {
    "output/PerfectEQ.json".source = ./effects/PerfectEQ.json;
    "output/AdvAutoGain.json".source = ./effects/AdvAutoGain.json;
  };
}
