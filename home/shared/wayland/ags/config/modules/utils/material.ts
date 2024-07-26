import Widget from "resource:///com/github/Aylur/ags/widget.js";

export default (icon, size, props) => {
  const cN = `icon-material txt-${size} ` + (props.className || "");
  if (props.className !== undefined) {
    delete props.className;
  };
  return Widget.Label({
    className: cN,
    label: `${icon}`,
    ...props,
  });
};
