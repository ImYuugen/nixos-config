import Widget from "resource:///com/github/Aylur/ags/widget.js";

export default ({ child }) => Widget.Box({
  className: "bar-group-margin",
  child: Widget.Box({
    className: "bar-group bar-group-standalone bar-group-spaced bar-group-pad-system",
    child,
  }),
});
