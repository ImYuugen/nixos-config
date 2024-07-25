import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

const WindowTitle = () => Widget.Scrollable({
  hexpand: true, vexpand: true,
  hscroll: "automatic", vscroll: "never",
  child: Widget.Box({
    vertical: true,
    children: [
      Widget.Label({
        xalign: 0,
        truncate: "end",
        maxWidthChars: 1,
        className: "txt-smaller bar-window-title-desc txt",
        setup: (self) => {
          self.hook(Hyprland.active.client, label => {
            label.label =
              Hyprland.active.client.class.length === 0 ?
                "Desktop" :
                Hyprland.active.client.class;
          })
        },
      }),
      Widget.Label({
        xalign: 0,
        truncate: "end",
        maxWidthChars: 1,
        className: "txt-smallie bar-window-title",
        setup: (self) => {
          self.hook(Hyprland.active, label => {
            label.label =
              Hyprland.active.client.title.length === 0 ?
                `Workspace ${Hyprland.active.workspace.id}` :
                Hyprland.active.client.title;
          })
        },
      }),
    ],
  }),
});

export default () => Widget.Box({
  homogeneous: false,
  children: [
    Widget.Box({ className: "bar-corner-spacer" }),
    WindowTitle(),
  ],
});
