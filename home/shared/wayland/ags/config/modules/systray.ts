import systemtray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

const MaxTrayWidth = 4;
const TrayItemSquare = 20; // 20px

const TrayItem = (item) => Widget.Button({
  className: "system-tray-item",
  child: Widget.Icon({
      hpack: "center",
    }).bind("icon", item, "icon"),
  tooltipMarkup: item.bind("tooltip_markup"),
  onPrimaryClick: (_, event) => item.activate(event),
  onSecondaryClick: (_, event) => item.openMenu(event),
});

export default (monitor = 0) => Widget.Window({
  monitor,
  name: `systray${monitor}`,
  exclusivity: "normal",
  anchor: [ "top", "right" ],
  visible: false,
  child: Widget.Box({
    className: "system-tray-container",
    child: Widget.Box({
      className: "spacing-5",
      children: systemtray.bind("items").as(items => items.map(TrayItem)),
    }),
  }),
});
