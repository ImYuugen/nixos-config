import BarGroup from "../../utils/bargroup.ts";
import CircProg from "../../utils/circprog.ts";

import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

const lowBatteryThresh = 20;

// TODO(Battery): Revealer that shows remaining time/power draw
const BatteryProgress = () => {
  const _updateProgress = (progress) => {
    progress.css = `font-size: ${Math.abs(Battery.percent)}px`;
    progress.toggleClassName(
      "bar-battery-circprog-low",
      Battery.percent <= lowBatteryThresh
    );
  }
  return CircProg({
    className: "bar-battery-circprog",
    vpack: "center",
    hpack: "center",
    extraSetup: (self) => self
      .hook(Battery, _updateProgress),
  });
};

const BatteryIcon = () => {
  const _updateColor = (progress) => {
    progress.toggleClassName(
      "bar-battery-label-icon-low",
      Battery.percent <= lowBatteryThresh
    );
  };
  return Widget.Label({
    className: "bar-battery-label-icon",
    label: "󰁹",
    setup: (self) => self.hook(Battery, _updateColor),
  });
};

const BatteryCapacity = Widget.Box({
  className: "bar-battery",
  children: [
    Widget.Label({
      className: "bar-battery-text",
      label: Battery.bind("percent").as(p => `${p}% `),
    }),
    Widget.Overlay({
      child: Widget.Box({
        className: "bar-battery",
        homogeneous: true,
        child: BatteryIcon(),
      }),
      overlays: [
        BatteryProgress(),
      ],
    }),
    Widget.Revealer({
      transitionDuration: 300,
      transition: "slide_right",
      revealChild: Battery.bind("charging"),
      child: Widget.Label("󱐋"),
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
        setup: (self) => {
          self.hook(Battery, box => {
            box.toggleClassName("bar-battery-low", Battery.percent <= lowBatteryThresh);
          })
        },
      }),
    ],
  })
});
