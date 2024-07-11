const { Gdk, Gtk } = imports.gi;
import Cairo from "cairo";
import Pango from "gi://Pango";
const PangoCairo = imports.gi.PangoCairo;
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

const wsCount = 10;

const workspaceClass = Widget.Box({ className: "bar-ws" });
const activeWorkspaceClass = Widget.Box({ className: "bar-ws bar-ws-active" });
const occupiedWorkspaceClass = Widget.Box({ className: "bar-ws bar-ws-occupied" });

const workspacesArea = () => {
  return Widget.DrawingArea({
    attribute: {
      initialized: false,
      // nth bit represents if nth ws has a window on it
      occupiedWsMask: 0,
      wsGroup: 0,
      updateMask: (self) => {
        self.attribute.occupiedWsMask =
          Hyprland.workspaces
            .filter(ws => ws.id > 0 && ws.id <= wsCount)
            .reduce((acc, ws) => acc |= 1 << ws.id, 0);
        self.queue_draw();
      },
    },
    setup: (area) => area
      .hook(Hyprland.active.workspace, (self) => {
        self.setCss(`font-size: ${(Hyprland.active.workspace.id - 1) % wsCount + 1}px;`);
        const prevGrp = self.attribute.wsGroup;
        const currGrp = Math.floor((Hyprland.active.workspace.id - 1) / wsCount);
        if (prevGrp != currGrp) {
          self.attribute.updateMask(self);
          self.attribute.wsGroup = currGrp;
        }
      })
      .hook(Hyprland, (self) => self.attribute.updateMask(self), "notify::workspaces")
      .on("draw", ((area, cr) => {
        const { height } = area.get_allocation();

        const wsc = workspaceClass.get_style_context();
        const wsDiam = wsc.get_property("min-width", Gtk.StateFlags.NORMAL);
        const wsRadi = wsDiam / 2;
        const wsFontSize = wsc.get_property("font-size", Gtk.StateFlags.NORMAL) / 4 * 3;
        const wsFontFami = wsc.get_property("font-family", Gtk.StateFlags.NORMAL);
        const wsFg = wsc.get_property("color", Gtk.StateFlags.NORMAL);

        const owsc = occupiedWorkspaceClass.get_style_context();
        const owsBg = owsc.get_property("background-color", Gtk.StateFlags.NORMAL);
        const owsFg = owsc.get_property("color", Gtk.StateFlags.NORMAL);

        const awsc = activeWorkspaceClass.get_style_context();
        const awsBg = awsc.get_property("background-color", Gtk.StateFlags.NORMAL);
        const awsFg = awsc.get_property("color", Gtk.StateFlags.NORMAL);

        area.set_size_request(wsDiam * wsCount, -1);
        const widgetSc = area.get_style_context();
        const awsFontSize = widgetSc.get_property("font-size", Gtk.StateFlags.NORMAL);
        const awsCenterX = wsDiam * awsFontSize - wsRadi;
        const awsCenterY = height / 2;

        const layout = PangoCairo.create_layout(cr);
        layout.set_font_description(Pango.font_description_from_string(`${wsFontFami[0]} ${wsFontSize}`));
        cr.setAntialias(Cairo.Antialias.BEST);
        layout.set_text("0".repeat(wsCount.toString().length), -1);
        const [ layoutW, layoutH ] = layout.get_pixel_size();
        const indRadi = Math.max(layoutW, layoutH) / 2 * 1.2;

        for (let i = 1; i <= wsCount; i++) {
          if (area.attribute.occupiedWsMask & (1 << i)) {
            cr.setSourceRGBA(owsBg.red, owsBg.green, owsBg.blue, owsBg.alpha);
            const wsCenX = wsDiam * i - wsRadi;
            const wsCenY = height / 2;
            // Check if left side is in workspace group
            if (!(area.attribute.occupiedWsMask & (1 << (i - 1)))) {
              cr.arc(wsCenX, wsCenY, wsRadi, 0.5 * Math.PI, 1.5 * Math.PI);
              cr.fill();
            } else {
              cr.rectangle(wsCenX - wsRadi, wsCenY - wsRadi, wsRadi, wsDiam);
              cr.fill();
            }
            // Check if right side is in workspace group
            if (!(area.attribute.occupiedWsMask & (1 << (i + 1)))) {
              cr.arc(wsCenX, wsCenY, wsRadi, -0.5 * Math.PI, 0.5 * Math.PI);
              cr.fill();
            } else {
              cr.rectangle(wsCenX, wsCenY - wsRadi, wsRadi, wsDiam);
              cr.fill();
            }
            cr.setSourceRGBA(owsFg.red, owsFg.green, owsFg.blue, owsFg.alpha);
          } else {
            cr.setSourceRGBA(wsFg.red, wsFg.green, wsFg.blue, wsFg.alpha);
          }
          layout.set_text(`${i}`, -1);
          const [ layoutW, layoutH ] = layout.get_pixel_size();
          const x = wsDiam * i - layoutW / 2 - wsRadi;
          const y = (height - layoutH) / 2;
          cr.moveTo(x, y);
          PangoCairo.show_layout(cr, layout);
          cr.stroke();
        }
        cr.setSourceRGBA(awsBg.red, awsBg.green, awsBg.blue, awsBg.alpha);
        cr.arc(awsCenterX, awsCenterY, indRadi, 0, 2 * Math.PI);
        cr.fill();
        cr.setSourceRGBA(awsFg.red, awsFg.green, awsFg.blue, awsFg.alpha);
        cr.arc(awsCenterX, awsCenterY, indRadi * 0.2, 0, 2 * Math.PI);
        cr.fill();
      }).bind(area))
  });
};

export default () => Widget.EventBox({
  onScrollUp: () => Hyprland.messageAsync("dispatch workspace -1").catch(print),
  onScrollDown: () => Hyprland.messageAsync("dispatch workspace +1").catch(print),
  attribute: {
    clicked: false,
  },
  child: Widget.Box({
    homogeneous: true,
    className: "bar-group-margin",
    children: [
      Widget.Box({
        className: "bar-group bar-group-standalone bar-group-pad",
        children: [workspacesArea()],
      }),
    ]
  }),
  setup: (self) => {
    self.add_events(Gdk.EventMask.POINTER_MOTION_MASK);
    self.on("button-press-event", (self, event) => {
      if (event.get_button()[1] === 1) {
        self.attribute.clicked = true;
        const cursorX = event.get_coords()[1];
        const widgetWidth = self.get_allocation().width;
        const wsId = Math.ceil(cursorX * wsCount / widgetWidth);
        console.log(wsId);
        Hyprland.messageAsync(`dispatch workspace ${wsId}`).catch(print);
      }
    });
    self.on("button-release-event", (self) => self.attribute.clicked = false);
  }
});
