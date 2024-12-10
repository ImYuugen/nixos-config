import { bind, Variable } from "astal";
import { Graph, GraphFill } from "../../utils/Graph";
import { humanReadable } from "../../utils/strings";
import Gtk from "gi://Gtk?version=3.0";

// TODO: Right click on CPU -> All cores + Power profiles
// Put CPU temperature somewhere
// Right click on Disk -> All mounted disks

// Get CPU usage (freq) every 4 seconds
// This lil' dude "forces" the graph update every two seconds
let cpuDelta = 0.1;
const cpuUsage = Variable(0).watch(["vmstat", "2"], (out) => {
    cpuDelta *= -1;
    return 100 - parseInt(out.split("\n").pop()?.split(/ +/)[14]!!) + cpuDelta;
});
const cpuFreqPath = "/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq";
const cpuFreq = Variable(0).poll(
    4000,
    ["cat", cpuFreqPath],
    (out) => parseInt(out) * 1000,
);
const cpuTempPath = "/sys/class/thermal/thermal_zone0/temp";
const cpuTemp = Variable(0).poll(
    2000,
    ["cat", cpuTempPath],
    (out) => parseInt(out) / 1000 + cpuDelta,
);

// No need for delta since there are, like, 14 digits of accuracy
const ramUsage = Variable([0, 0]).poll(2000, ["free", "-b"], (out) => {
    const line = out
        .split("\n")
        .find((line) => line.includes("Mem"))
        ?.split(/ +/) ?? ["0", "1", "0", "0"];
    // 100 * free / total
    const used = parseInt(line[2]),
        total = parseInt(line[1]);
    return [(100 * used) / total, used];
});

// Don't need faster than 20 seconds
const diskRootUsage = Variable(0).poll(20000, "df", (out) => {
    // Line that ends in '/' <=> Root disk
    const line =
        out
            .split("\n")
            .find((l) => /\/$/.test(l))
            ?.split(/ +/) ?? [];
    return parseInt((line[4] ?? "0%").slice(0, -1));
});

function System() {
    return (
        <box className="system-module">
            <overlay
                className="cpu"
                tooltipText={bind(cpuUsage).as((u) => u.toString())}
            >
                <Graph
                    className="graph percent"
                    value={bind(cpuUsage)}
                    samples={20}
                    fill={GraphFill.FULL}
                />
                <Graph
                    className="graph temp"
                    value={bind(cpuTemp)}
                    samples={20}
                    fill={GraphFill.NONE}
                    maxValue={150}
                />
                <label
                    className="component-icon"
                    label=""
                    halign={Gtk.Align.START}
                    valign={Gtk.Align.START}
                />
                <label
                    className="graph-text"
                    label={bind(cpuFreq).as((c) =>
                        humanReadable(c, "Hz", true, 2),
                    )}
                    halign={Gtk.Align.END}
                    valign={Gtk.Align.START}
                />
            </overlay>
            <overlay
                className="ram"
                tooltipText={bind(ramUsage).as((f) =>
                    f[0].toLocaleString(undefined, {
                        maximumFractionDigits: 2,
                    }),
                )}
            >
                <Graph
                    className="graph"
                    value={ramUsage((f) => f[0])}
                    samples={10}
                    fill={GraphFill.FULL}
                />
                <label
                    className="component-icon"
                    label=""
                    halign={Gtk.Align.START}
                    valign={Gtk.Align.START}
                />
                <label
                    className="graph-text"
                    label={bind(ramUsage).as((f) =>
                        humanReadable(f[1], "B", false, 2),
                    )}
                    halign={Gtk.Align.END}
                    valign={Gtk.Align.START}
                />
            </overlay>
        </box>
    );
}

export default System;
