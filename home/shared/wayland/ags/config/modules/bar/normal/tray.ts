import App from "resource:///com/github/Aylur/ags/app.js";
import Variable from "resource:///com/github/Aylur/ags/variable.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

import Material from "../../utils/material.ts";

const folded = Variable(true);

export default (monitor = 0) => Widget.EventBox({
  className: "bar-tray-button",
  onPrimaryClick: () => {
    folded.setValue(!folded.value);
    App.toggleWindow(`systray${monitor}`);
  },
  child: Widget.Stack({
    homogeneous: true,
    children: {
      "folded": Material(
        "keyboard_arrow_down",
        "norm",
        {
          className: "bar-tray-arrow",
        }
      ),
      "unfolded": Material(
        "keyboard_arrow_up",
        "norm",
        {
          className: "bar-tray-arrow",
        }
      ),
    },
    shown: "folded",
    setup: (self) => {
      self.hook(folded, (self) => {
        self.shown = folded.value ? "folded" : "unfolded";
      });
    },
  }),
});
