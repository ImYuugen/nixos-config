{ ... }:

let
  temperatures = {
    base = 6500;
    night = 5000;
  };
in
{
  services.hyprsunset = {
    enable = true;
    transitions = {
      preSunrise = {
        calendar = "*-*-* 06:00:00";
        requests = [
          [
            "temperature"
            "${builtins.toString ((temperatures.base + temperatures.night) / 2)}"
          ]
        ];
      };
      sunrise = {
        calendar = "*-*-* 08:00:00";
        requests = [
          [ "identity" ]
          [
            "gamma"
            "100"
          ]
        ];
      };
      preSunset = {
        calendar = "*-*-* 20:00:00";
        requests = [
          [
            "temperature"
            "${builtins.toString ((temperatures.base + temperatures.night) / 2)}"
          ]
        ];
      };
      sunset = {
        calendar = "*-*-* 22:00:00";
        requests = [
          [
            "temperature"
            "${builtins.toString temperatures.night}"
          ]
        ];
      };
    };
  };
}
