import BarGroup from "../../utils/bargroup.ts";

import Variable from "resource:///com/github/Aylur/ags/variable.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

const time = Variable("00:00:00", {
  poll: [5000, "date \"+%H:%M\""],
});
const date = Variable("Ayo date is fucked up", {
  poll: [5000, "date \"+%A, %d/%m\""]
});

const DateModule = () => Widget.EventBox({
  child: Widget.Box({
    className: "bar-clock-box",
    children: [
      Widget.Label({
        className: "bar-time",
        label: time.bind(),
      }),
      Widget.Label(" - "),
      Widget.Label({
        className: "bar-date",
        label: date.bind(),
      })
    ],
  }),
});

export default () => BarGroup({ child: DateModule() });
