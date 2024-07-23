import Gtk from "gi://Gtk";
import Utils from "resource:///com/github/Aylur/ags/utils.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

/*
  min-height == diameter
  min-width == line thickness
  padding == space between circle and progress
  margin == space between widget and parent
  bg-color == progress color
  color == circle color
  font-size == progress
*/
export default ({
  from = 0,
  to = 0,
  animTime = 2900,
  animPoint = 1,
  extraSetup,
  ...other
}) => Widget.DrawingArea({
  ...other,
  css: from != to ? `font-size: ${from}px; transition: ${animTime}ms linear;` : '',
  setup: (self) => {
    const styleCtx = self.get_style_context();
    const w = styleCtx.get_property("min-height", Gtk.StateFlags.NORMAL);
    const h = w;
    const margin = styleCtx.get_margin(Gtk.StateFlags.NORMAL);
    self.set_size_request(w + margin.left + margin.right, h + margin.top + margin.bottom);
    self.connect("draw", ((self, cr) => {
      const styleCtx = self.get_style_context();
      const w = styleCtx.get_property("min-height", Gtk.StateFlags.NORMAL);
      const h = w;
      const pad = styleCtx.get_padding(Gtk.StateFlags.NORMAL).left;
      const margin = styleCtx.get_margin(Gtk.StateFlags.NORMAL);
      self.set_size_request(w + margin.left + margin.right, h + margin.top + margin.bottom);

      let progress = styleCtx.get_property("font-size", Gtk.StateFlags.NORMAL) / 100;
      const bgStroke = styleCtx.get_property("min-width", Gtk.StateFlags.NORMAL);
      const fgStroke = bgStroke - pad;
      const radius = Math.min(w, h) / 2.0 - Math.max(bgStroke, fgStroke) / 2.0;
      const cenX = w / 2.0 + margin.left;
      const cenY = h / 2.0 + margin.top;

      if (progress === 0) {
        // cr.arc won't draw if start === end
        progress += 0.0001;
      }
      const startAngle = -Math.PI / 2.0;
      const endAngle = startAngle + (2.0 * Math.PI * progress);
      const bgCol = styleCtx.get_property("background-color", Gtk.StateFlags.NORMAL);
      cr.setSourceRGBA(bgCol.red, bgCol.green, bgCol.blue, bgCol.alpha);
      cr.arc(cenX, cenY, radius, endAngle, startAngle);
      cr.setLineWidth(bgStroke);
      cr.stroke();

      const col = styleCtx.get_property("color", Gtk.StateFlags.NORMAL);
      cr.setSourceRGBA(col.red, col.green, col.blue, col.alpha);
      cr.arc(cenX, cenY, radius, startAngle, endAngle);
      cr.setLineWidth(fgStroke);
      cr.stroke();
    }).bind(self));

    if (from != to) {
      Utils.interval(1000, () => {
        self.css = `font-size: ${to}px`;
      }, self);
      const transitionDistance = to - from;
      const oneStep = animTime / animPoint;
      self.css = `font-size: ${to}px; transition: ${oneStep}ms linear;`;
      for (let i = 0; i < animPoint; i++) {
        Utils.timeout(Math.max(10, i * oneStep), () => {
          if (!self) return;
          self.css = from != to ? `font-size: ${from + (transitionDistance / animPoint * (i + 1))}px;` : "";
        })
      }
    }
    else {
      self.css = "font-size: 0px";
    }
    extraSetup(self);
  }
});
