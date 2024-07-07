import Widget from "resource:///com/github/Aylur/ags/widget.js"; 

export const Bar = (monitor = 0) => {
  const normalContent = Widget.CenterBox({
    className: "bar-normal",
    startWidget: Widget.Box({
      className: "bar-start-box",
      children: [],
    }),
    centerWidget: Widget.Box({
      className: "bar-center-box",
      children: [
        Widget.Label("Hewwo :3"),
      ],
    }),
    endWidget: Widget.Box({
      className: "bar-end-box",
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
      // Space evenly: false
      homogeneous: false,
      children: {
        'normal': normalContent,
        'hidden': noContent,
      },
      shown: 'normal'
    })
  });
};
