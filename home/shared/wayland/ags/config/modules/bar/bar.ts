import Widget from "resource:///com/github/Aylur/ags/widget.js"; 

import { enableClickThrough } from "../utils/clickthrough.ts";
import RoundedCorner from "../utils/roundedcorner.ts";

import battery from "./normal/battery.ts";
import date from "./normal/date.ts";
import system from "./normal/system.ts";
import title from "./normal/title.ts";
import tray from "./normal/tray.ts";
import workspaces from "./normal/workspaces.ts";

export const Bar = (monitor = 0) => {
  const normalContent = Widget.CenterBox({
    className: "bar-normal",
    startWidget: Widget.Box({
      children: [
        Widget.Box({ className: "bar-corner-spacer" }),
        title(),
      ],
    }),
    centerWidget: Widget.Box({
      children: [
        workspaces(),
        date(),
        battery(),
      ],
    }),
    endWidget: Widget.Box({
      hpack: "end",
      children: [
        tray(),
        system(),
        Widget.Box({ className: "bar-corner-spacer" }),
      ],
    }),
  });
  const noContent = Widget.Box({
    className: "bar-empty",
  });
  
  return Widget.Window({
    monitor,
    name: `bar${monitor}`,
    // Top centered
    anchor: [ "top", "left", "right" ],
    // Reserve space
    exclusivity: "exclusive",
    visible: true,
    child: Widget.Stack({
      homogeneous: false,
      children: {
        'normal': normalContent,
        'hidden': noContent,
      },
      shown: 'normal'
    })
  });
};

export const BarCornerTopLeft = (monitor = 0) => Widget.Window({
  monitor,
  name: `bar-cornertl${monitor}`,
  layer: "top",
  anchor: [ "top", "left" ],
  exclusivity: "normal",
  visible: true,
  child: RoundedCorner("topleft", { className: "corner", }),
  setup: enableClickThrough,
});

export const BarCornerTopRight = (monitor = 0) => Widget.Window({
  monitor,
  name: `bar-cornertr${monitor}`,
  layer: "top",
  anchor: [ "top", "right" ],
  exclusivity: "normal",
  visible: true,
  child: RoundedCorner("topright", { className: "corner", }),
  setup: enableClickThrough,
});
