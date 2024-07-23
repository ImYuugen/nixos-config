import Widget from "resource:///com/github/Aylur/ags/widget.js"; 

import battery from "./normal/battery.ts";
import date from "./normal/date.ts";
import workspaces from "./normal/workspaces.ts";

export const Bar = (monitor = 0) => {
  const normalContent = Widget.CenterBox({
    className: "bar-normal",
    startWidget: Widget.Box({
      children: [],
    }),
    centerWidget: Widget.Box({
      children: [
        workspaces(),
        date(),
        battery(),
      ],
    }),
    endWidget: Widget.Box({
      children: [],
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
