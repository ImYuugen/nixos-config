import CircProg from "../../utils/circprog.ts";
import Material from "../../utils/material.ts";

import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

const lowBatteryThresh = 20;

// TODO(Battery): Revealer that shows remaining time/power draw
const BatteryProgress = () => CircProg({
  className: "bar-battery-circprog",
  vpack: "center",
  hpack: "center",
  extraSetup: (self) => self.hook(
    Battery,
    (self) => {
      self.css = `font-size: ${Math.abs(Battery.percent)}px`;
      self.toggleClassName(
        "bar-battery-circprog-low",
        Battery.percent <= lowBatteryThresh && !Battery.charging
      );
    }
  )
});

const BatteryIcon = () => Widget.Label({
  className: "bar-battery-icon",
  label: "󰁹",
  setup: (self) => self.hook(
    Battery,
    (self) => self.toggleClassName(
      "bar-battery-icon-low",
      Battery.percent <= lowBatteryThresh && !Battery.charging
    )),
  }
);

const BatteryText = () => Widget.Label({
  className: "bar-battery-text",
  label: Battery.bind("percent").as(p => `${p}%`),
  setup: (self) => self.hook(
    Battery,
    (self) => self.toggleClassName(
      "bar-battery-text-low",
      Battery.percent <= lowBatteryThresh && !Battery.charging
    )),
});

const BatteryCapacity = Widget.Box({
  children: [
    BatteryText(),
    Widget.Overlay({
      child: Widget.Box({
        className: "bar-battery",
        homogeneous: true,
        // child: BatteryIcon(),
        child: Material(
          "battery_full",
          "small",
          {
            className: "bar-battery-icon",
            setup: (self) => self.hook(
              Battery,
              (self) => self.toggleClassName(
                "bar-battery-icon-low",
                Battery.percent <= lowBatteryThresh && !Battery.charging
              )
            ),
          },
        ),
      }),
      overlays: [
        BatteryProgress(),
      ],
    }),
    Widget.Revealer({
      transitionDuration: 300,
      transition: "slide_right",
      revealChild: Battery.bind("charging"),
      child: Material(
        "bolt",
        "norm",
        { tooltipText: "Charging", },
      ),
    }),
  ],
});

export default () => Widget.EventBox({
  child: Widget.Box({
    className: "bar-group-margin",
    children: [
      Widget.EventBox({
        className: "bar-group bar-group-standalone bar-group-pad",
        child: BatteryCapacity,
        tooltipText: Battery.bind("time_remaining").as(t => {
          const h = Math.floor(t / 3600);
          t = t % 3600;
          const m = Math.floor(t / 60);
          t = t % 60;
          return `${h}:${m}:${t}`;
        }),
        setup: (self) => {
          self.hook(Battery, box => {
            box.toggleClassName(
              "bar-battery-low",
              Battery.percent <= lowBatteryThresh && !Battery.charging
            );
          })
        },
      }),
    ],
  })
});
