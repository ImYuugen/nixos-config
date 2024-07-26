import CircProg from "../../utils/circprog.ts";
import Material from "../../utils/material.ts";

import Variable from "resource:///com/github/Aylur/ags/variable.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js"; 

const CpuUsage = Variable("0", {
  poll: [2500, "top -bn1", output => `${Math.ceil(100 - +(output
    .split("\n")
    .find(line => line.includes("Cpu(s)"))
    ?.replace(/.*, *([0-9.]*)%* id.*/, "$1") || "0"))}`],
});
const CpuCircProg = () => {
  return CircProg({
    className: "bar-system-item-circprog",
    vpack: "center",
    hpack: "center",
    extraSetup: (self) => {
      self.hook(CpuUsage, () => {
        self.css = `font-size: ${CpuUsage.value}px;`;
        self.tooltipText = `CPU: ${CpuUsage.value}%`;
      })
    },
  });
};
const CpuLoad = () => Widget.Box({
  className: "bar-system-item",
  child: Widget.Overlay({
    overlays: [
      Widget.Box({
        homogeneous: true,
        child: Material(
          "developer_board",
          "norm",
          {}
        ),
      })
    ],
    child: Widget.Box({
      children: [
        CpuCircProg(),
      ],
    }),
  }),
});

const DiskUsage = Variable("0", {
  poll: [20000, "df", output => output
    .split("\n")
    .find(line => line.match(/.*\/$/))
    ?.replace(/.* ([0-9]*)%.*/, "$1") || "0"
  ],
});
const DiskCircProg = () => {
  return CircProg({
    className: "bar-system-item-circprog",
    vpack: "center",
    hpack: "center",
    extraSetup: (self) => {
      self.hook(DiskUsage, () => {
        self.css = `font-size: ${DiskUsage.value}px;`;
        self.tooltipText = `/ : ${DiskUsage.value}%`;
      })
    },
  });
};
const DiskLoad = () => Widget.Box({
  className: "bar-system-item",
  child: Widget.Overlay({
    overlays: [
      Widget.Box({
        homogeneous: true,
        child: Widget.Label({
          label: "/",
        }),
      })
    ],
    child: Widget.Box({
      children: [
        DiskCircProg(),
      ],
    }),
  }),
});

const MemoryUsage = Variable("0", {
  poll: [2500, "free", output => {
    const tf = output
      .split("\n")
      .find(line => line.includes("Mem:"))
      ?.split(/\s+/) || [1, 1];
    return `${Math.ceil(+tf[2] / +tf[1] * 100)}`;
  }],
});
const MemoryCircProg = () => {
  return CircProg({
    className: "bar-system-item-circprog",
    vpack: "center",
    hpack: "center",
    extraSetup: (self) => {
      self.hook(MemoryUsage, () => {
        self.css = `font-size: ${MemoryUsage.value}px;`;
        self.tooltipText = `RAM: ${MemoryUsage.value}%`;
      })
    },
  });
};
const MemoryLoad = () => Widget.Box({
  className: "bar-system-item",
  child: Widget.Overlay({
    overlays: [
      Widget.Box({
        homogeneous: true,
        child: Material(
          "memory",
          "norm",
          {},
        ),
      })
    ],
    child: Widget.Box({
      children: [
        MemoryCircProg(),
      ],
    }),
  }),
});

export default () => Widget.Box({
  className: "bar-group-margin",
  child: Widget.Box({
    className: "bar-group bar-group-standalone bar-group-pad",
    children: [
      MemoryLoad(),
      CpuLoad(),
      DiskLoad(),
    ],
  })
});
